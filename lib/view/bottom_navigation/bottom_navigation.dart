import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/view/bottom_navigation/nav_bar_dot.dart';
import 'package:health_tourism/view/chats/chats_view.dart';
import 'package:health_tourism/view/clinics/clinics.dart';
import 'package:health_tourism/view/landing/landing_view.dart';
import 'package:health_tourism/view/profile_view/profile_view.dart';
import 'package:health_tourism/view/splash/splash_view.dart';
import '../../cubit/bottom_navigation/bottom_navigation_cubit.dart';
import '../../cubit/bottom_navigation/bottom_navigation_state.dart';

class HTBottomNav extends StatefulWidget {
  @override
  _HTBottomNavState createState() => _HTBottomNavState();
}

class _HTBottomNavState extends State<HTBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarCubit(),
      child: BlocConsumer<NavbarCubit, NavbarState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NavbarCubit.get(context);
          return Scaffold(
            bottomNavigationBar: CustomBottomNavBar(
              onChange: (index) {
                cubit.changeBottomNavBar(index);
              },
              defaultSelectedIndex: 0,
            ),
            extendBody: true,
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: cubit.pageController,
              onPageChanged: (index) {
                cubit.changeBottomNavBar(index);
              },
              children: const [
                LandingView(),
                ChatsView(),
                ProfileView(),
              ],
            )
          );
        },
      ),
    );
  }
}