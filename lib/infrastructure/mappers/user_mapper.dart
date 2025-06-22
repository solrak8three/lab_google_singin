import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_singin/domain/entities/user.dart' as domain;
class UserMapper {
  static domain.User fromFirebase(firebase.User user) {
    return domain.User(
      id: user.uid,
      name: user.displayName ?? 'Sin nombre',
      email: user.email ?? 'Sin email',
      photoUrl: user.photoURL,
    );
  }
}
