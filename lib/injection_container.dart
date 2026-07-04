import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_application/core/network/network_info.dart';
import 'package:quiz_application/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:quiz_application/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:quiz_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:quiz_application/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:quiz_application/features/auth/domain/usecases/login_usecase.dart';
import 'package:quiz_application/features/auth/domain/usecases/logout_usecase.dart';
import 'package:quiz_application/features/auth/domain/usecases/signup_usecase.dart';
import 'package:quiz_application/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  // bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUsecase: sl(),
      signupUsecase: sl(),
      logoutUsecase: sl(),
      createUserUsecase: sl(),
    ),
  );
  // useCases
  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => SignupUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => CreateUserUsecase(authRepository: sl()));
  // repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(networkInfo: sl(), remoteDatasource: sl()),
  );
  // dataSources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(auth: sl(), firestore: sl()),
  );
  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  // external
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance,);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance,);
}
