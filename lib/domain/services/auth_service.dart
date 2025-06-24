import 'package:google_singin/domain/entities/user.dart' as domain;

abstract class AuthService {
  Stream<domain.User?> get authStateChanges;
  domain.User? get currentUser;
  Future<domain.User> signInWithGoogle();
  Future<void> signOut();
}
