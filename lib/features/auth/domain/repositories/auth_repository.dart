import 'package:dartz/dartz.dart';
import 'package:quiz_application/core/error/failure.dart';
import 'package:quiz_application/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, Unit>> createUser(UserEntity entity);
}
