import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';

import '../../core/components/ht_icon.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/dimen.dart';
import '../../core/constants/horizontal_space.dart';
import '../../core/constants/theme/styles.dart';
import '../../product/navigation/router.dart';
import '../../product/services/settings_utils.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  List<SettingUtils> settingsList = SettingUtils.userSettingsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HTIcon(iconName: AssetConstants.icons.leftChevron,
                  onPress: () {
                context.pop();
                },),
                const VerticalSpace(spaceAmount: DimenConstant.LARGE),
                Expanded(
                  child: ListView.builder(
                      itemCount: settingsList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onListItemTap(index);
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: <Widget>[
                                    const Divider(
                                      height: 1.5,
                                      color: Colors.grey,
                                    ),
                                    Icon(settingsList[index].iconData,
                                        color: Colors.grey.shade400),
                                    const HorizontalSpace(
                                      spaceAmount: DimenConstant.LARGE,
                                    ),
                                    Text(
                                      settingsList[index].titleTxt!,
                                      style: htLabelBlackStyle,
                                    ),
                                    const Spacer(),
                                    HTIcon(
                                      iconName: AssetConstants.icons.rightChevron,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1.5,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        );
                      }),
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
