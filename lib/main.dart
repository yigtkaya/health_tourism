import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/view/splash/splash_view.dart';

import 'core/services/firebase_auth_service.dart';
import 'cubit/auth/auth_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthService(),
      child: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(FirebaseAuthService()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashView(),
        ),
      ),
    );
  }
}

