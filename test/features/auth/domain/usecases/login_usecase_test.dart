import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/features/auth/domain/entities/auth_response.dart';
import 'package:plexuspules/features/auth/domain/usecases/login_usecase.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  const tParams = LoginParams(email: 'test@test.com', password: 'password123');
  const tAuthResponse = AuthResponse(
    accessToken: 'token',
    userId: '1',
    userEmail: 'test@test.com',
    userName: 'Test User',
    userRole: 'admin',
  );

  test(
    'should call login on the repository',
    () async {
      // arrange
      when(() => mockAuthRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => const Right(tAuthResponse));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, const Right(tAuthResponse));
      verify(() => mockAuthRepository.login(
            email: tParams.email,
            password: tParams.password,
          )).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
