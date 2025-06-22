import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_singin/infrastructure/mappers/user_mapper.dart';
import 'package:google_singin/infrastructure/services/auth_services.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial()) {
    _authService.authStateChanges.listen((firebaseUser) {
      if (firebaseUser != null) {
        final domainUser = UserMapper.fromFirebase(firebaseUser);
        emit(Authenticated(domainUser));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      final userCredential = await _authService.signInWithGoogle();
      final domainUser = UserMapper.fromFirebase(userCredential.user!);
      emit(Authenticated(domainUser));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    emit(Unauthenticated());
  }
}
