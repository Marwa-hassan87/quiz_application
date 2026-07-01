import 'package:dartz/dartz.dart';
import 'package:quiz_application/core/error/failure.dart';
import 'package:quiz_application/features/auth/domain/repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository authRepository;

  SignupUsecase({required this.authRepository});
  Future<Either<Failure, Unit>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await authRepository.signUp(
      name: name,
      email: email,
      password: password,
    );
  }
}
