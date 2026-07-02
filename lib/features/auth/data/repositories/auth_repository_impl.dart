import 'package:dartz/dartz.dart';
import 'package:quiz_application/core/error/exception.dart';
import 'package:quiz_application/core/error/failure.dart';
import 'package:quiz_application/core/network/network_info.dart';
import 'package:quiz_application/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:quiz_application/features/auth/data/models/auth_model.dart';
import 'package:quiz_application/features/auth/data/models/signup_model.dart';
import 'package:quiz_application/features/auth/domain/entities/auth_entity.dart';
import 'package:quiz_application/features/auth/domain/entities/signup_entity.dart';
import 'package:quiz_application/features/auth/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl({
    required NetworkInfo networkInfo,
    required AuthRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _networkInfo = networkInfo;
  @override
  Future<Either<Failure, Unit>> createUser(AuthEntity entity) async {
    if (await _networkInfo.isConnected) {
      final AuthModel model = AuthModel(
        id: entity.id,
        name: entity.name,
        email: entity.email,
      );
      try {
        await _remoteDatasource.createUser(model);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDatasource.login(email: email, password: password);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDatasource.logout();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> signUp(SignupEntity entity) async {
    try {
      final SignupModel model = SignupModel(
        name: entity.name,
        email: entity.email,
        password: entity.password,
      );
      final user = await _remoteDatasource.signUp(model);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
