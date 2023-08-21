import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/auth/auth_cubit.dart';
import 'package:health_tourism/cubit/profile/profile_cubit.dart';
import 'package:health_tourism/cubit/profile/profile_cubit_state.dart';
import 'package:health_tourism/product/models/customer.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/navigation/router.dart';

import '../../core/components/ht_text.dart';
import '../../core/constants/horizontal_space.dart';
import '../../product/theme/styles.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late User customer;

  @override
  void initState() {
    // TODO: implement initState
    context.read<ProfileCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: const Color(0xff2D9CDB),
        elevation: 0,
        centerTitle: true,
        title: HTText(
          label: "My Profile",
          style: htToolBarLabel,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VerticalSpace(
              spaceAmount: 30,
            ),
            userInfo(),
            const VerticalSpace(
              spaceAmount: 40,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: settings.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: index == 5
                            ? () {
                                context.read<AuthCubit>().signOut();
                              }
                            : () {
                                context.pushNamed(
                                    '/${settings[index].toString().replaceAll(" ", "")}',
                                    queryParameters: {
                                      'title': settings[index]
                                    });
                                print("object");
                              },
                        child: getSettings(
                            iconList[index], settings[index], index));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  List settings = [
    "Personal Info",
    "My Appointments",
    "My Favorites",
    "Payment Methods",
    "Help",
    "Log Out",
  ];

  List iconList = [
    AssetConstants.icons.profileUnSelected,
    AssetConstants.icons.emptyStar,
    AssetConstants.icons.appointment,
    AssetConstants.icons.payment,
    AssetConstants.icons.help,
    AssetConstants.icons.logout,
  ];

  Widget userInfo() {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                  "https://image.shutterstock.com/image-photo/hospital-interior-operating-surgery-table-260nw-1407429638.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const VerticalSpace(),
        HTText(label: "John Doe", style: htTitleStyle),
        HTText(label: "hasan.kaya@gmail.com", style: htBlueLabelStyle),
      ],
    );
  }

  Widget getSettings(String iconName, String label, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              HTIcon(
                iconName: iconName,
                width: 24,
                height: 24,
                color: const Color(0xff123258),
              ),
              const HorizontalSpace(spaceAmount: 16),
              HTText(label: label, style: htDarkBlueBoldLargeStyle),
              const Spacer(),
              index == 5
                  ? const SizedBox.shrink()
                  : HTIcon(
                      iconName: AssetConstants.icons.chevronRight,
                      color: const Color(0xff123258),
                      width: 16,
                      height: 16),
            ],
          ),
          index == 5 ? const SizedBox.shrink() : const Divider(
            color: Color(0xffd3e3f1),
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
