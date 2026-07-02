import 'package:dartz/dartz.dart';
import 'package:quiz_application/core/error/failure.dart';
import 'package:quiz_application/features/auth/data/models/auth_model.dart';
import 'package:quiz_application/features/auth/domain/entities/auth_entity.dart';
import 'package:quiz_application/features/auth/domain/entities/signup_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, AuthEntity>> signUp(SignupEntity entity);
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, Unit>> createUser(AuthEntity entity);
}
