import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/dimen.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(alignment: Alignment.center, child: profileTitle()),
                const VerticalSpace(),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      // fotoğraf alanı için komponent
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0)),
                          child: Image.asset("assets/images/yigit.jpg"),
                        ),
                      ),
                      const HorizontalSpace(
                        spaceAmount: DimenConstant.VERY_LARGE,
                      ),
                      const HTText(
                          label: ("İsim Soyisim + Yaş"),
                          style: htLabelBlackStyle),
                    ],
                  ),
                ),
                const VerticalSpace(),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: settingsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onListItemTap(index);
                        },
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        settingsList[index].titleTxt!,
                                        style: htLabelBoldBlackStyle,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Icon(settingsList[index].iconData,
                                        color: Colors.amber),
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Divider(
                                height: 1,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
