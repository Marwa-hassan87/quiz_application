import 'package:dartz/dartz.dart';
import 'package:quiz_application/core/error/failure.dart';
import 'package:quiz_application/features/auth/domain/entities/auth_entity.dart';
import 'package:quiz_application/features/auth/domain/entities/signup_entity.dart';
import 'package:quiz_application/features/auth/domain/repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository authRepository;

  SignupUsecase({required this.authRepository});
  Future<Either<Failure, AuthEntity>> call(SignupEntity entity) async {
    return await authRepository.signUp(entity);
  }
}
