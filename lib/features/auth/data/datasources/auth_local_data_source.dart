import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/secure_storage_service.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String> getCachedToken();
  Future<void> clearToken();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService _storageService;

  AuthLocalDataSourceImpl(this._storageService);

  @override
  Future<void> cacheToken(String token) async {
    await _storageService.saveAccessToken(token);
  }

  @override
  Future<String> getCachedToken() async {
    final token = await _storageService.getAccessToken();
    if (token == null) {
      throw const CacheException('No cached token found');
    }
    return token;
  }

  @override
  Future<void> clearToken() async {
    await _storageService.clearAll();
  }
}
