import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/exceptions.dart';
import 'package:plexuspules/core/error/failures.dart';
import 'package:plexuspules/features/auth/data/models/auth_request_model.dart';
import 'package:plexuspules/features/auth/data/models/auth_response_model.dart';
import 'package:plexuspules/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:plexuspules/features/auth/domain/entities/auth_response.dart';
import 'package:plexuspules/features/auth/data/models/user_model.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    registerTestFallbacks();
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockNetworkInfo,
    );
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password123';
  const tAuthRequestModel = AuthRequestModel(email: tEmail, password: tPassword);
  const tAuthResponseModel = AuthResponseModel(
    accessToken: 'token',
    user: UserModel(
      id: '1',
      email: tEmail,
      name: 'Test User',
      role: 'admin',
    ),
  );
  const tAuthResponse = AuthResponse(
    accessToken: 'token',
    userId: '1',
    userEmail: tEmail,
    userName: 'Test User',
    userRole: 'admin',
  );

  group('login', () {
    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.login(any())).thenAnswer((_) async => tAuthResponseModel);
      when(() => mockLocalDataSource.cacheToken(any())).thenAnswer((_) async => {});

      // act
      await repository.login(email: tEmail, password: tPassword);

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when login is successful', () async {
        // arrange
        when(() => mockRemoteDataSource.login(any())).thenAnswer((_) async => tAuthResponseModel);
        when(() => mockLocalDataSource.cacheToken(any())).thenAnswer((_) async => {});

        // act
        final result = await repository.login(email: tEmail, password: tPassword);

        // assert
        verify(() => mockRemoteDataSource.login(tAuthRequestModel));
        expect(result, const Right(tAuthResponse));
      });

      test('should cache the token locally when login is successful', () async {
        // arrange
        when(() => mockRemoteDataSource.login(any())).thenAnswer((_) async => tAuthResponseModel);
        when(() => mockLocalDataSource.cacheToken(any())).thenAnswer((_) async => {});

        // act
        await repository.login(email: tEmail, password: tPassword);

        // assert
        verify(() => mockRemoteDataSource.login(tAuthRequestModel));
        verify(() => mockLocalDataSource.cacheToken(tAuthResponseModel.accessToken));
      });

      test('should return UnauthorizedFailure on UnauthorizedException', () async {
        // arrange
        when(() => mockRemoteDataSource.login(any())).thenThrow(const UnauthorizedException());

        // act
        final result = await repository.login(email: tEmail, password: tPassword);

        // assert
        expect(result, const Left(UnauthorizedFailure('Invalid email or password')));
      });

      test('should return ServerFailure on ServerException', () async {
        // arrange
        when(() => mockRemoteDataSource.login(any())).thenThrow(ServerException('Server Error'));

        // act
        final result = await repository.login(email: tEmail, password: tPassword);

        // assert
        expect(result, const Left(ServerFailure('Server Error')));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return NetworkFailure when device is offline', () async {
        // act
        final result = await repository.login(email: tEmail, password: tPassword);

        // assert
        expect(result, const Left(NetworkFailure()));
      });
    });
  });
}
