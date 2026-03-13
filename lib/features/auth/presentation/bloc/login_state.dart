import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_response.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final AuthResponse authResponse;

  const LoginSuccess(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}
