import 'package:dartz/dartz.dart';
import 'package:quiz_application/core/error/failure.dart';
import 'package:quiz_application/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.logout();
  }
}
