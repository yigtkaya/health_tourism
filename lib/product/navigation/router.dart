import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:health_tourism/view/landing/landing_view.dart';
import 'package:health_tourism/view/login/login_view.dart';
import 'package:health_tourism/view/root/root_view.dart';
import 'package:health_tourism/view/splash/splash_view.dart';

import '../../view/onboarding/onboarding_view.dart';
import '../../view/sign_up/sign_up_view.dart';

class RoutePath {
  RoutePath._();

  static const String root = '/';
  static const String splash = '/splash';
  static const String landing = '/landing';
  static const String signIn = '/signIn';
  static const String register = '/register';
  static const String onBoarding = '/onBoarding';

}

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: RoutePath.landing,
      builder: (context, state) {
        return const LandingView();
      }),
  GoRoute(
      path: RoutePath.onBoarding,
      builder: (context, state) {
        return const OnBoardingView();
      }),
  GoRoute(
      path: RoutePath.splash,
      builder: (context, state) {
        return const SplashView();
      }),
  GoRoute(
      path: RoutePath.root,
      builder: (context, state) {
        return const RootView();
      }),
  GoRoute(
      path: RoutePath.signIn,
      builder: (context, state) {
        return  const LoginView();
      }),
  GoRoute(
      path: RoutePath.register,
      builder: (context, state) {
        return const SignUpView();
      }),
],);

void goTo({required String path}) {
  router.go(path);
}

void goToWithWait({required String path}) {
  Future.delayed(const Duration(seconds: 5), () {
    router.go(path);
  });
}

void goBack() {
  router.pop();
}