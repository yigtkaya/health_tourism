import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingUtils {
  String? titleTxt;
  String? subTxt;
  IconData iconData;
  bool isSelected;

  SettingUtils({
    this.titleTxt = '',
    this.isSelected = false,
    this.subTxt = '',
    this.iconData = Icons.supervised_user_circle,
  });

  List<SettingUtils> getCountryListFromJson(Map<String, dynamic> json) {
    List<SettingUtils> countryList = [];
    if (json['countryList'] != null) {
      json['countryList'].forEach((v) {
        SettingUtils data = SettingUtils();
        data.titleTxt = v["name"];
        data.subTxt = v["code"];
        countryList.add(data);
      });
    }
    return countryList;
  }

  static List<SettingUtils> userSettingsList = [
    SettingUtils(
      titleTxt: 'Edit Personal Data',
      isSelected: false,
      iconData: FontAwesomeIcons.user,
    ),
    SettingUtils(
      titleTxt: 'Change password',
      isSelected: false,
      iconData: FontAwesomeIcons.lock,
    ),
    SettingUtils(
      titleTxt: 'Invite Friends',
      isSelected: false,
      iconData: FontAwesomeIcons.userFriends,
    ),
    SettingUtils(
      titleTxt: 'Credits & Coupons',
      isSelected: false,
      iconData: FontAwesomeIcons.gift,
    ),
    SettingUtils(
      titleTxt: 'Help Center',
      isSelected: false,
      iconData: FontAwesomeIcons.infoCircle,
    ),
    SettingUtils(
      titleTxt: 'Payments',
      isSelected: false,
      iconData: FontAwesomeIcons.wallet,
    ),
    SettingUtils(
      titleTxt: 'Settings',
      isSelected: false,
      iconData: FontAwesomeIcons.cog,
    )
  ];
  static List<SettingUtils> settingsList = [
    SettingUtils(
      titleTxt: 'Notifications',
      isSelected: false,
      iconData: FontAwesomeIcons.solidBell,
    ),
    SettingUtils(
      titleTxt: 'Country',
      isSelected: false,
      iconData: FontAwesomeIcons.userFriends,
    ),
    SettingUtils(
      titleTxt: 'Currency',
      isSelected: false,
      iconData: FontAwesomeIcons.gift,
    ),
    SettingUtils(
      titleTxt: 'Terms of Services',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    ),
    SettingUtils(
      titleTxt: 'Privacy Policy',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    ),
    SettingUtils(
      titleTxt: 'Give Us Feedbacks',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    ),
    SettingUtils(
      titleTxt: 'Log out',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    )
  ];

  static List<SettingUtils> currencyList = [
    SettingUtils(
      titleTxt: 'Australia Dollar',
      subTxt: "\$ AUD",
    ),
    SettingUtils(
      titleTxt: 'Argentina Peso',
      subTxt: "\$ ARS",
    ),
    SettingUtils(
      titleTxt: 'Indian rupee',
      subTxt: "₹ Rupee",
    ),
    SettingUtils(
      titleTxt: 'United States Dollar',
      subTxt: "\$ USD",
    ),
    SettingUtils(
      titleTxt: 'Chinese Yuan',
      subTxt: "¥ Yuan",
    ),
    SettingUtils(
      titleTxt: 'Belgian Euro',
      subTxt: "€ Euro",
    ),
    SettingUtils(
      titleTxt: 'Brazilian Real',
      subTxt: "R\$ Real",
    ),
    SettingUtils(
      titleTxt: 'Canadian Dollar',
      subTxt: "\$ CAD",
    ),
    SettingUtils(
      titleTxt: 'Cuban Peso',
      subTxt: "₱ PESO",
    ),
    SettingUtils(
      titleTxt: 'French Euro',
      subTxt: "€ Euro",
    ),
    SettingUtils(
      titleTxt: 'Hong Kong Dollar',
      subTxt: "\$ HKD",
    ),
    SettingUtils(
      titleTxt: 'Italian Lira',
      subTxt: "€ Euro",
    ),
    SettingUtils(
      titleTxt: 'New Zealand Dollar',
      subTxt: "\$ NZ",
    ),
  ];

  static List<SettingUtils> helpSearchList = [
    SettingUtils(
      titleTxt: 'Paying for a reservation',
      subTxt: "",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "How do I cancel my rooms reservation?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "What methods pf payment does Roome accept?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
    SettingUtils(
      titleTxt: 'Trust and safety',
      subTxt: "",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "I'm a guest. What are some safety tips I can follow?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
    SettingUtils(
      titleTxt: 'Paying for a reservation',
      subTxt: "",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "How do I cancel my rooms reservation?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "What methods pf payment does Roome accept?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
    SettingUtils(
      titleTxt: 'Trust and safety',
      subTxt: "",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "I'm a guest. What are some safety tips I can follow?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingUtils(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
  ];

  static List<SettingUtils> subHelpList = [
    SettingUtils(
      titleTxt: "",
      subTxt:
      "You can cancel a reservation any time before Or during your trip. To cancel a reservation:",
    ),
    SettingUtils(
      titleTxt: "",
      subTxt:
      "GO to Trips and choose yotr trip\nClick Your home reservation\nClick Modify reservation",
    ),
    SettingUtils(
      titleTxt: "",
      subTxt:
      "You'll be taken to a new page where you either change or cancel your reservation. Click the Next button under Cancel reservation to Start the cancellation process.",
    ),
    SettingUtils(
      titleTxt: "",
      subTxt:
      "If you cancel, your refund Will be determined by your host'r cancellation policy. We'll show your refund breakdown before you finalize the cancellation.",
    ),
    SettingUtils(
      titleTxt: "",
      subTxt: "Give feedback",
      isSelected: true,
    ),
    SettingUtils(
      titleTxt: "Related articles",
      subTxt: "",
    ),
    SettingUtils(
      titleTxt: "",
      subTxt: "Can I change a reservation as a guest?",
    ),
    SettingUtils(
      titleTxt: "",
      subTxt: "HOW do I cancel a reservation request?",
    ),
    SettingUtils(
      titleTxt: "",
      subTxt: "What is the Resolution Center?",
    ),
  ];

  static List<SettingUtils> userInfoList = [
    SettingUtils(
      titleTxt: '',
      subTxt: "",
    ),
    SettingUtils(
      titleTxt: 'UserName',
      subTxt: "Amanda Jane",
    ),
    SettingUtils(
      titleTxt: 'Email',
      subTxt: "amanda@gmail.com",
    ),
    SettingUtils(
      titleTxt: 'Phone',
      subTxt: "+65 1122334455",
    ),
    SettingUtils(
      titleTxt: 'Date of birth',
      subTxt: "20, Aug, 1990",
    ),
    SettingUtils(
      titleTxt: 'Address',
      subTxt: "123 Royal Street, New York",
    ),
  ];
}