sealed class AuthState {}
class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class ErrorState extends AuthState {
  final String message;

  ErrorState({required this.message});
}

class SuccessState extends AuthState {
  final String message;

  SuccessState({required this.message});
}
