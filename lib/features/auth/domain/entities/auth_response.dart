import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String accessToken;
  final String userId;
  final String userEmail;
  final String userName;
  final String userRole;

  const AuthResponse({
    required this.accessToken,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userRole,
  });

  @override
  List<Object> get props => [
    accessToken,
    userId,
    userEmail,
    userName,
    userRole,
  ];
}
