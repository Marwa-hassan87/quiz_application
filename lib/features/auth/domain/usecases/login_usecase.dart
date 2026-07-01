import 'package:dartz/dartz.dart';
import 'package:quiz_application/core/error/failure.dart';
import 'package:quiz_application/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});
  Future<Either<Failure, Unit>> call({
    required String email,
    required String password,
  }) async {
    return await authRepository.login(email: email, password: password);
  }
}
