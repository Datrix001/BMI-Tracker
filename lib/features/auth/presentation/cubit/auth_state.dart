sealed class AuthState {}

class AuthLoading extends AuthState {}

class AuthInitial extends AuthState {}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthPasswordResetEmailSent extends AuthState {}

class AuthOtpVerifies extends AuthState {}

class AuthPasswordUpdated extends AuthState {}
