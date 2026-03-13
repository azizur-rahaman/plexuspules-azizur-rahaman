import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/exceptions.dart';
import 'package:plexuspules/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:plexuspules/features/auth/data/models/user_model.dart';
import 'package:plexuspules/features/auth/data/models/auth_request_model.dart';
import 'package:plexuspules/features/auth/data/models/auth_response_model.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = AuthRemoteDataSourceImpl(mockDioClient);
    registerFallbackValue(RequestOptions(path: ''));
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password123';
  const tAuthRequestModel = AuthRequestModel(email: tEmail, password: tPassword);
  final tResponseData = {
    'token': 'token',
    'user': {
      'id': '1',
      'email': tEmail,
      'name': 'Test User',
      'role': 'admin',
    }
  };
  const tAuthResponseModel = AuthResponseModel(
    accessToken: 'token',
    user: UserModel(
      id: '1',
      email: tEmail,
      name: 'Test User',
      role: 'admin',
    ),
  );

  group('login', () {
    test(
      '''should perform a POST request on a URL with login endpoint 
      and with the correct body''',
      () async {
        // arrange
        when(() => mockDioClient.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer(
          (_) async => Response(
            data: tResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // act
        await dataSource.login(tAuthRequestModel);

        // assert
        verify(() => mockDioClient.post(
              '/auth/login',
              data: tAuthRequestModel.toJson(),
            ));
      },
    );

    test(
      'should return AuthResponseModel when the response code is 200 (success)',
      () async {
        // arrange
        when(() => mockDioClient.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer(
          (_) async => Response(
            data: tResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // act
        final result = await dataSource.login(tAuthRequestModel);

        // assert
        expect(result, equals(tAuthResponseModel));
      },
    );

    test(
      'should throw UnauthorizedException when the response code is 401',
      () async {
        // arrange
        when(() => mockDioClient.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(
          DioException(
            response: Response(
              statusCode: 401,
              requestOptions: RequestOptions(path: ''),
            ),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // act
        final call = dataSource.login;

        // assert
        expect(() => call(tAuthRequestModel), throwsA(const TypeMatcher<UnauthorizedException>()));
      },
    );

    test(
      'should throw ServerException when the response code is other than 200 or 401',
      () async {
        // arrange
        when(() => mockDioClient.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(
          DioException(
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: ''),
            ),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // act
        final call = dataSource.login;

        // assert
        expect(() => call(tAuthRequestModel), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
