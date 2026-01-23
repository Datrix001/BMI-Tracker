abstract class AuthRepository {
  Future<void> signInWithGithub();
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Future<void> signUpUsingEmail(String email, String password);
  Future<void> signInUsingEmail(String email, String password);
  Future<void> sendResetPasswordForEmail(String email);
  Future<void> sendToken(String email, String otp);

  Future<void> updatePassword(String password);
}
