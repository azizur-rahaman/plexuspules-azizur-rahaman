import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../models/auth_request_model.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Authenticates a user with email and password.
  /// Throws [UnauthorizedException] for wrong credentials.
  /// Throws [ServerException] for other server errors.
  Future<AuthResponseModel> login(AuthRequestModel request);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthResponseModel> login(AuthRequestModel request) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    // Validate credentials — credentials are never exposed in UI
    const validEmail = 'admin@plexus.com';
    const validPassword = 'password123';

    if (request.email != validEmail || request.password != validPassword) {
      throw const UnauthorizedException();
    }

    // Generate a dummy JWT
    final header = base64Url.encode(utf8.encode('{"alg":"HS256","typ":"JWT"}'));
    final payload = base64Url.encode(
      utf8.encode(
        '{"sub":"usr_plexus_001","email":"admin@plexus.com",'
        '"name":"Admin User","role":"admin",'
        '"iat":${DateTime.now().millisecondsSinceEpoch ~/ 1000},'
        '"exp":${(DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600}}',
      ),
    );
    // Dummy signature (not cryptographically valid — for mock purposes only)
    const signature = 'plexuspulse_dummy_sig';
    final fakeJwt = '$header.$payload.$signature';

    return AuthResponseModel(
      accessToken: fakeJwt,
      tokenType: 'Bearer',
      expiresIn: 3600,
      user: const UserModel(
        id: 'usr_plexus_001',
        email: 'admin@plexus.com',
        name: 'Admin User',
        role: 'admin',
      ),
    );
  }
}
