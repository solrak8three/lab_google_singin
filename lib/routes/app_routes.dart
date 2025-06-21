import 'package:go_router/go_router.dart';
import 'package:google_singin/presentation/screens/home_screen.dart';
import 'package:google_singin/presentation/screens/login_screen.dart';

final routes = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);