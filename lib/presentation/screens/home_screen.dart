import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_singin/presentation/cubits/auth/auth_cubit.dart';
import 'package:google_singin/presentation/cubits/auth/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is Unauthenticated || current is Authenticated,
      listener: (context, state) {
        if (state is Unauthenticated) {
          // Redirige de forma segura al login
          Future.microtask(() => context.go('/login'));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final user = state.user;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user.photoUrl != null)
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.photoUrl!),
                  ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextButton(
                  child: const Text('Sign Out'),
                  onPressed: () => context.read<AuthCubit>().signOut(),
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
