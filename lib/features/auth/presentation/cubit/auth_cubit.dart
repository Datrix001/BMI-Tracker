import 'dart:async';
import 'package:bmi_tracker/features/auth/presentation/screens/new_password_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'auth_state.dart';
import '../../data/repository/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  late final StreamSubscription _sub;

  var isRecoveringPassword = false;

  AuthCubit(this.repository) : super(AuthInitial()) {
    _emitInitialSession();

    _sub = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (data.session != null) {
        if (!isRecoveringPassword) {
          emit(AuthAuthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  void _emitInitialSession() {
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      await repository.signInWithGoogle();
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> signInWithGithub() async {
    emit(AuthLoading());
    try {
      await repository.signInWithGithub();
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> signInUsingEmail(String email, String password) async {
    emit(AuthLoading());
    try {
      await repository.signInUsingEmail(email, password);
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> signUpUsingEmail(String email, String password) async {
    emit(AuthLoading());
    try {
      await repository.signUpUsingEmail(email, password);
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await repository.signOut();
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    emit(AuthLoading());
    try {
      await repository.sendResetPasswordForEmail(email);
      emit(AuthPasswordResetEmailSent());
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> updatePassword(String password) async {
    emit(AuthLoading());
    try {
      await repository.updatePassword(password);
      isRecoveringPassword = false;
      emit(AuthPasswordUpdated());
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> sendToken(String email, String otp) async {
    emit(AuthLoading());
    try {
      isRecoveringPassword = true;

      await repository.sendToken(email, otp);
      emit(AuthOtpVerifies());
    } catch (e) {
      isRecoveringPassword = false;
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}
