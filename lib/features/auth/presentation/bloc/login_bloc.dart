import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final PushNotificationService _pushNotificationService;

  LoginBloc(this._loginUseCase, this._pushNotificationService) : super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());

    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    await result.fold(
      (failure) async => emit(LoginFailure(failure.message)),
      (authResponse) async {
        await _pushNotificationService.registerToken();
        emit(LoginSuccess(authResponse));
      },
    );
  }
}
