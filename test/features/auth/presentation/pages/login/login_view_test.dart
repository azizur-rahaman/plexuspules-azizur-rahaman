import 'package:bloc_test/bloc_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_bloc.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_event.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_state.dart';
import 'package:plexuspules/features/auth/presentation/pages/login/login_view.dart';
import 'package:plexuspules/core/widgets/primary_button.dart';
import '../../../../../helpers/test_helpers.dart';

void main() {
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    registerTestFallbacks();
    
    // Default stub for states stream
    when(() => mockLoginBloc.state).thenReturn(const LoginInitial());
    when(() => mockLoginBloc.stream).thenAnswer((_) => Stream.value(const LoginInitial()));
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<LoginBloc>.value(
        value: mockLoginBloc,
        child: const LoginView(),
      ),
    );
  }

  testWidgets('should show welcome text and sign in button', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(milliseconds: 500)); // Handle initState delay
    await tester.pump(); // Handle animation

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('should show loading indicator when state is LoginLoading', (WidgetTester tester) async {
    when(() => mockLoginBloc.state).thenReturn(const LoginLoading());
    when(() => mockLoginBloc.stream).thenAnswer((_) => Stream.value(const LoginLoading()));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    final primaryButton = tester.widget<PrimaryButton>(find.byType(PrimaryButton));
    expect(primaryButton.isLoading, true);
  });

  testWidgets('should add LoginSubmitted event when sign in button is pressed with valid form', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    await tester.enterText(find.byType(TextFormField).first, 'test@test.com');
    await tester.enterText(find.byType(TextFormField).last, 'password123');
    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    verify(() => mockLoginBloc.add(any(that: isA<LoginSubmitted>()))).called(1);
  });
}

// Simple InheritedWidget to mock GoRouter
class InheritedGoRouter extends InheritedWidget {
  final GoRouter goRouter;

  const InheritedGoRouter({
    super.key,
    required this.goRouter,
    required super.child,
  });

  @override
  bool updateShouldNotify(InheritedGoRouter oldWidget) => goRouter != oldWidget.goRouter;

  static GoRouter of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedGoRouter>()!.goRouter;
}
