import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/view/bottom_navigation/nav_bar_dot.dart';
import 'package:health_tourism/view/clinics/clinics.dart';
import 'package:health_tourism/view/profile_view/profile_view.dart';
import 'package:health_tourism/view/splash/splash_view.dart';

import '../../bottom_navigation_state.dart';
import '../../cubit/bottom_navigation/bottom_navigation_cubit.dart';
import '../landing/landing_view.dart';

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

            bottomNavigationBar: CustomBottomNavBarDash(
              onChange: (index) {
                cubit.changeBottomNavBar(index);
              },
              defaultSelectedIndex: 0,
              backgroundColor: Colors.grey.shade100,
              showLabel: false,
              textList: const [
                'Home',
                'Messages',
                'Profile',
              ],
              iconList: const  [
                Icons.home_outlined,
                Icons.message,
                Icons.person_outline,
              ],
            ),
            extendBody: true,
            body: PageView(
              controller: cubit.pageController,
              onPageChanged: (index) {
                cubit.changeBottomNavBar(index);
              },
              children: const [
                ClinicsView(),
                SplashView(),
                ProfileView(),
              ],
            )
          );
        },
      ),
    );
  }
}