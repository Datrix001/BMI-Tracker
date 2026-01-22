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
}
