import 'package:dartz/dartz.dart';
import 'package:quiz_application/core/error/failure.dart';
import 'package:quiz_application/features/auth/data/models/auth_model.dart';
import 'package:quiz_application/features/auth/domain/entities/user_entity.dart';
import 'package:quiz_application/features/auth/domain/repositories/auth_repository.dart';

class CreateUserUsecase {
  final AuthRepository _authRepository;

  CreateUserUsecase({required AuthRepository authRepository}) : _authRepository = authRepository;
  Future<Either<Failure,Unit>> call(UserEntity entity)async{
    return await _authRepository.createUser(entity);
  }
}