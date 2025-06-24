import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_singin/firebase_options.dart';
import 'package:google_singin/injection.dart';
import 'package:google_singin/presentation/cubits/auth/auth_cubit.dart';
import 'package:google_singin/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  setupLocator();
  final authCubit = getIt<AuthCubit>();

  runApp(
    BlocProvider.value(
      value: authCubit, 
      child: MyApp(authCubit: authCubit),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthCubit authCubit;

  const MyApp({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Google Singin',
      routerConfig: createRouter(authCubit),
    );
  }
}