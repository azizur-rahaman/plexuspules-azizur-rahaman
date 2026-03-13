import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/exceptions.dart';
import 'package:plexuspules/features/auth/data/datasources/auth_local_data_source.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late AuthLocalDataSourceImpl dataSource;
  late MockSecureStorageService mockSecureStorageService;

  setUp(() {
    mockSecureStorageService = MockSecureStorageService();
    dataSource = AuthLocalDataSourceImpl(mockSecureStorageService);
  });

  group('cacheToken', () {
    test('should call SecureStorageService to cache the token', () async {
      // arrange
      const tToken = 'test_token';
      when(() => mockSecureStorageService.saveAccessToken(any()))
          .thenAnswer((_) async => {});

      // act
      await dataSource.cacheToken(tToken);

      // assert
      verify(() => mockSecureStorageService.saveAccessToken(tToken));
    });
  });

  group('getCachedToken', () {
    test('should return cached token when it exists', () async {
      // arrange
      const tToken = 'test_token';
      when(() => mockSecureStorageService.getAccessToken())
          .thenAnswer((_) async => tToken);

      // act
      final result = await dataSource.getCachedToken();

      // assert
      expect(result, tToken);
      verify(() => mockSecureStorageService.getAccessToken());
    });

    test('should throw CacheException when there is no cached token', () async {
      // arrange
      when(() => mockSecureStorageService.getAccessToken())
          .thenAnswer((_) async => null);

      // act
      final call = dataSource.getCachedToken;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('clearToken', () {
    test('should call SecureStorageService to clear all data', () async {
      // arrange
      when(() => mockSecureStorageService.clearAll())
          .thenAnswer((_) async => {});

      // act
      await dataSource.clearToken();

      // assert
      verify(() => mockSecureStorageService.clearAll());
    });
  });
}
