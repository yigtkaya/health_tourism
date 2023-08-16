import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/dialog/image_dialog.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/view/bottom_navigation/bottom_navigation.dart';
import 'package:health_tourism/view/chats/fullsecreen_image.dart';
import 'package:health_tourism/view/forgot_password/forgot_password.dart';
import 'package:health_tourism/view/landing/landing_view.dart';
import 'package:health_tourism/view/login/login_view.dart';
import 'package:health_tourism/view/payment/payment_view.dart';
import 'package:health_tourism/view/profile_view/profile_view.dart';
import 'package:health_tourism/view/root/root_view.dart';
import 'package:health_tourism/view/splash/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/message/message_cubit.dart';
import '../../view/chats/chat_room_view.dart';
import '../../view/chats/send_image_view.dart';
import '../../view/clinics/clinic_detail_view.dart';
import '../../view/onboarding/onboarding_view.dart';
import '../../view/sign_up/sign_up_view.dart';
import '../models/buyer.dart';
import '../models/package.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: RoutePath.landing,
      builder: (context, state) {
        return const LandingView();
      },
    ),
    GoRoute(
      path: RoutePath.onBoarding,
      builder: (context, state) {
        return const OnBoardingView();
      },
    ),
    GoRoute(
      path: RoutePath.fullscreenImage,
      name: RoutePath.fullscreenImage,
      builder: (context, state) {
        return FullScreenImageViewer(state.queryParameters['imageUrl'] ?? '');
      },
    ),
    GoRoute(
      path: RoutePath.clinicDetail,
      name: RoutePath.clinicDetail,
      builder: (context, state) {
        return ClinicDetailView(clinicId: state.queryParameters['clinicId'] ?? '',);
      },
    ),
    GoRoute(
      path: RoutePath.sendImage,
      name: RoutePath.sendImage,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => MessageCubit(),
          child: SendImageView(
            imagePath: state.queryParameters['imageFile'] ?? '',
            receiverId: state.queryParameters['receiverId'] ?? '',
          ),
        );
      },
    ),
    GoRoute(
      path: RoutePath.splash,
      builder: (context, state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: RoutePath.root,
      builder: (context, state) {
        return const RootView();
      },
    ),
    GoRoute(
      path: RoutePath.signIn,
      builder: (context, state) {
        return const LoginView();
      },
    ),
    GoRoute(
      path: RoutePath.bottomNavigation,
      builder: (context, state) {
        return HTBottomNav();
      },
    ),
    GoRoute(
      path: RoutePath.profile,
      builder: (context, state) {
        return const ProfileView();
      },
    ),
    GoRoute(
      path: RoutePath.register,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          key: state.pageKey,
          child: const SignUpView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's value
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
        path: RoutePath.forgotPassword,
        builder: (context, state) {
          return const ForgotPasswordView();
        }),
    GoRoute(
      path: RoutePath.payment,
      builder: (context, state) {
        return PaymentView(null, null, null);
      },
    ),
    GoRoute(
      path: RoutePath.imagePickerDialog,
      name: RoutePath.imagePickerDialog,
      builder: (context, state) {
        return ImagePickerDialog(
          receiverId: state.queryParameters['receiverId'] ?? '',
        );
      },
    ),
    GoRoute(
      path: RoutePath.chatRoom,
      name: RoutePath.chatRoom,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => MessageCubit()
            ..getChat(chatRoomId: state.queryParameters['chatRoomId']!),
          child: ChatRoomView(
            receiverId: state.queryParameters['receiverId']!,
            chatRoomId: state.queryParameters['chatRoomId']!,
            receiverName: state.queryParameters['receiverName']!,
          ),
        );
      },
    ),
  ],
);

void goTo({required String path}) {
  router.go(path);
}

void pushTo({required String path}) {
  router.push(path);
}

void goToWithWait({required String path}) {
  Future.delayed(const Duration(seconds: 5), () {
    router.go(path);
  });
}

void goBack() {
  router.pop();
}

