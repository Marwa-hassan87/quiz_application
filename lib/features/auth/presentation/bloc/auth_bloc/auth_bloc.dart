import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_application/core/error/failure.dart';
import 'package:quiz_application/core/strings/failures.dart';
import 'package:quiz_application/core/strings/messages.dart';
import 'package:quiz_application/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:quiz_application/features/auth/domain/usecases/login_usecase.dart';
import 'package:quiz_application/features/auth/domain/usecases/logout_usecase.dart';
import 'package:quiz_application/features/auth/domain/usecases/signup_usecase.dart';
import 'package:quiz_application/features/auth/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:quiz_application/features/auth/presentation/bloc/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  final LogoutUsecase logoutUsecase;
  final CreateUserUsecase createUserUsecase;
  AuthBloc(
    {
    required this.loginUsecase,
    required this.signupUsecase,
    required this.logoutUsecase,
    required this.createUserUsecase,
  }) :super(InitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingState());
        final result = await loginUsecase.call(
          email: event.email,
          password: event.password,
        );
        result.fold(
          (failure) => emit(ErrorState(message: getMessage(failure))),
          (_) => emit(SuccessState(message: loginMessage)),
        );
      } else if (event is SignUpEvent) {
        emit(LoadingState());
        final signUpResult = await signupUsecase.call(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        await signUpResult.fold((failure) async=> emit(ErrorState(message: getMessage(failure))), (
          userEntity,
        ) async {
          final createUserResult = await createUserUsecase.call(userEntity);
          createUserResult.fold(
            (failure) => emit(ErrorState(message: getMessage(failure))),
            (_) => emit(SuccessState(message: signUpMessage)),
          );
        });
      } else if (event is LogoutEvent) {
        emit(LoadingState());
        final result = await logoutUsecase.call();
        result.fold(
          (failure) => emit(ErrorState(message: getMessage(failure))),
          (_) => emit(SuccessState(message: logoutMessage)),
        );
      }
    });
  }
  String getMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure():
        return serverFailureMessage;
      case OfflineFailure():
        return offlineFailureMessage;
      default:
        return 'UnExpected error ,please try again later';
    }
  }
}
