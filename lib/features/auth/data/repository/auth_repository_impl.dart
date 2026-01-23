import 'package:bmi_tracker/features/auth/data/datasources/auth_remote_datsource.dart';
import 'package:bmi_tracker/features/auth/data/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatsource remoteDatsource;

  AuthRepositoryImpl({required this.remoteDatsource});

  @override
  Future<void> signInWithGithub() async {
    return await remoteDatsource.signInWithGithub();
  }

  @override
  Future<void> signInWithGoogle() async {
    return await remoteDatsource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    return await remoteDatsource.signOut();
  }

  @override
  Future<void> signInUsingEmail(String email, String password) async {
    return await remoteDatsource.signInUsingEmail(email, password);
  }

  @override
  Future<void> signUpUsingEmail(String email, String password) async {
    return await remoteDatsource.signUpUsingEmail(email, password);
  }

  @override
  Future<void> sendResetPasswordForEmail(String email) async {
    return await remoteDatsource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> updatePassword(String password) async {
    return await remoteDatsource.updatePassword(password);
  }

  @override
  Future<void> sendToken(String otp, String email) async {
    return await remoteDatsource.sendToken(email, otp);
  }
}
