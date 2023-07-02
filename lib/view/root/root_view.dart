import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/firebase_auth_service.dart';
import '../../cubit/auth/AuthState.dart';
import '../../cubit/auth/auth_cubit.dart';
import '../../product/navigation/router.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthService(),
      child: BlocProvider(
        create: (context) => AuthCubit(context.read<FirebaseAuthService>()),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // TO DO: Navigate to landing page
              goTo(path: RoutePath.landing);
            } else if (state is NotAuthenticated) {
              // TO DO: Navigate to login page
              goTo(path: RoutePath.signIn);
            } else if (state is AuthError) {
              // TO DO: Show error message and navigate to login page
              goTo(path: RoutePath.signIn);
            } else if (state is FirstRun) {
              // TO DO: Navigate to onboarding page
              goTo(path: RoutePath.onBoarding);
            }
          },
          builder: (context, state) {
            return const Scaffold(
              body: Center(
                child: Text("Root Screen"),
              ),
            );
          },
        ),
      ),
    );
  }
}
