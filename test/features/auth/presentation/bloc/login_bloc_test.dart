import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/failures.dart';
import 'package:plexuspules/features/auth/domain/entities/auth_response.dart';
import 'package:plexuspules/features/auth/domain/usecases/login_usecase.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_bloc.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_event.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_state.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late LoginBloc bloc;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    registerTestFallbacks();
    mockLoginUseCase = MockLoginUseCase();
    bloc = LoginBloc(mockLoginUseCase);
  });

  const tAuthResponse = AuthResponse(
    accessToken: 'token',
    userId: '1',
    userEmail: 'test@test.com',
    userName: 'Test User',
    userRole: 'admin',
  );

  test('initial state should be LoginInitial', () {
    expect(bloc.state, const LoginInitial());
  });

  blocTest<LoginBloc, LoginState>(
    'emits [LoginLoading, LoginSuccess] when login is successful',
    build: () {
      when(() => mockLoginUseCase(any()))
          .thenAnswer((_) async => const Right(tAuthResponse));
      return bloc;
    },
    act: (bloc) => bloc.add(const LoginSubmitted(
      email: 'test@test.com',
      password: 'password123',
    )),
    expect: () => [
      const LoginLoading(),
      const LoginSuccess(tAuthResponse),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    'emits [LoginLoading, LoginFailure] when login fails',
    build: () {
      when(() => mockLoginUseCase(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(const LoginSubmitted(
      email: 'test@test.com',
      password: 'wrong_password',
    )),
    expect: () => [
      const LoginLoading(),
      const LoginFailure('Server Error'),
    ],
  );
}
