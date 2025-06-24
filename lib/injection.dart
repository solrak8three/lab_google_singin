import 'package:get_it/get_it.dart';
import 'package:google_singin/domain/services/auth_service.dart';
import 'package:google_singin/infrastructure/services/firebase_auth_service.dart';
import 'package:google_singin/presentation/cubits/auth/auth_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Service FirebaseAuthService with implementation of AuthService
  getIt.registerSingleton<AuthService>(FirebaseAuthService());

  // Cubit injection with the service
  getIt.registerFactory(() => AuthCubit(getIt<AuthService>()));
}
