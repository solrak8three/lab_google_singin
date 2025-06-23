import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_singin/presentation/screens/home_screen.dart';
import 'package:google_singin/presentation/screens/login_screen.dart';
import 'package:google_singin/presentation/cubits/auth/auth_cubit.dart';
import 'package:google_singin/presentation/cubits/auth/auth_state.dart';


GoRouter createRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      print('🔄 redirect ejecutado - estado actual: ${authCubit.state}');
      final authState = authCubit.state;

      // Espera a que el estado inicial cambie
      if (authState is AuthInitial) return null;

      final isLoggedIn = authState is Authenticated;
      final isAtLogin = state.matchedLocation == '/login';

      if (!isLoggedIn && !isAtLogin) {
        return '/login';
      }

      if (isLoggedIn && isAtLogin) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const HomeScreen(),
      ),
    ],
  );
}


class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((event) {
      print('🔄 GoRouterRefreshStream: Evento recibido: $event');
      notifyListeners();
  });

  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

