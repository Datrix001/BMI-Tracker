abstract class AuthRepository {
  Future<void> signInWithGithub();
  Future<void> signInWithGoogle();
  Future<void> signOut();
}
