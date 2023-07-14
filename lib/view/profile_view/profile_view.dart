import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_text.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Row(
                  children: [
                    // fotoğraf alanı için komponent
                    CircleAvatar(
                      radius: 36, // Image radius
                      backgroundImage: AssetImage('assets/images/yigit.jpg'),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: HTText(
                            label: ("Yiğit Kaya, 22"),
                            style: htLabelBoldBlackStyle),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Divider(
                        height: 1.5,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Icon(settingsList[6].iconData,
                            color: Colors.grey.shade400),
                      ),
                      const HorizontalSpace(
                        spaceAmount: DimenConstant.LARGE,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Expanded(
                          child: Text(
                            settingsList[6].titleTxt!,
                            style: htLabelBlackStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onListItemTap(int index) {
    // create switch case for each items titletxt and route to the page
    switch (settingsList[index].titleTxt) {
      case "Edit Personal Info":
        goTo(path: RoutePath.editProfile);
        break;
      case "Change Password":
        break;
      case "Invite Friends":
        break;
      case "Credit & Coupons":
        break;
      case "Help Center":
      case "Payments":
      case "Settings":
        goTo(path: RoutePath.settings);
        break;
    }
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
          text: 'Profile',
          style: htTitleStyle2,
        ),
      ],
    ),
  );
}
