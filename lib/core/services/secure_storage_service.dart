import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';
  static const _tokenTypeKey = 'token_type';

  SecureStorageService(this._storage);

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  Future<void> saveTokenType(String type) async {
    await _storage.write(key: _tokenTypeKey, value: type);
  }

  Future<String?> getTokenType() async {
    return _storage.read(key: _tokenTypeKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
