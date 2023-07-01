

// TODO: Implement Guard
import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:health_tourism/view/landing/landing_view.dart';
import 'package:health_tourism/view/login/LoginView.dart';
import 'package:health_tourism/view/root/root_view.dart';
import 'package:health_tourism/view/splash/splash_view.dart';

import '../../view/onboarding/onboarding_view.dart';
import '../../view/sign_up/sign_up_view.dart';

class RoutePath {
  RoutePath._();

  static const String landing = '/';
  static const String splash = '/splash';
  static const String login = '/landing';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String root = '/root';
  static const String onBoarding = '/onBoarding';

}

final GoRouter router = GoRouter(routes: [
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
      path: RoutePath.login,
      builder: (context, state) {
        return  LoginView();
      }),
  GoRoute(
      path: RoutePath.signUp,
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