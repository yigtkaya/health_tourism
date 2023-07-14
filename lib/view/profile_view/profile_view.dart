import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/dimen.dart';
import 'package:health_tourism/core/constants/gradient_colors.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/core/constants/theme/styles.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/profile/profile_cubit.dart';
import 'package:health_tourism/product/models/customer.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'package:health_tourism/product/services/settings_utils.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<SettingUtils> settingsList = SettingUtils.userSettingsList;

  late Customer customer;

  @override
  void initState() {
    // TODO: implement initState
    context.read<ProfileCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              profileTitle(),
              const VerticalSpace(spaceAmount: DimenConstant.VERY_LARGE),
              const CircleAvatar(
                radius: 60, // Image radius
                backgroundImage: AssetImage('assets/images/yigit.jpg'),
              ),
              const VerticalSpace(spaceAmount: DimenConstant.LARGE),
              const HTText(
                  label: ("Yiğit Kaya, 22"), style: htLabelBoldBlackStyle),
              Container(
                color: Colors.white,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  onListItemTap();
                  print("object");
                },
                child: Column(
                  children: <Widget>[
                    const Divider(
                      height: 1.5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: <Widget>[
                          const Divider(
                            height: 1.5,
                            color: Colors.grey,
                          ),
                          Icon(settingsList[6].iconData,
                              color: Colors.grey.shade400),
                          const HorizontalSpace(
                            spaceAmount: DimenConstant.LARGE,
                          ),
                          Text(
                            settingsList[6].titleTxt!,
                            style: htLabelBlackStyle,
                          ),
                          const Spacer(),
                          HTIcon(
                            iconName: AssetConstants.icons.rightChevron,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onListItemTap() {
    // create switch case for each items titletxt and route to the page
    GoRouter.of(context).push(RoutePath.settings);
  }
}

Widget profileTitle() {
  return Text.rich(
    TextSpan(
      style: GoogleFonts.inter(
        fontSize: 24,
        color: Colors.white,
        letterSpacing: 1.8,
      ),
      children: const [
        TextSpan(
          text: 'My Profile',
          style: htTitleStyle2,
        ),
      ],
    ),
  );
}
