import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String userId;
  final String userEmail;
  final String userName;
  final String userRole;

  const AuthResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userRole,
  });

  @override
  List<Object> get props => [
    accessToken,
    tokenType,
    expiresIn,
    userId,
    userEmail,
    userName,
    userRole,
  ];
}
