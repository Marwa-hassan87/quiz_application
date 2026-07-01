import 'package:dartz/dartz.dart';
import 'package:quiz_application/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> logout();
}
