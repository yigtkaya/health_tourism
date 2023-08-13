import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/product/theme/color/app_colors.dart';
import 'package:health_tourism/product/theme/theme_manager.dart';

var colours = AppColors();

var htHintTextStyle = GoogleFonts.nunitoSans(
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.darkBlueTextColor
      ?.withOpacity(0.5),
  letterSpacing: 1.2,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

final htDarkBlueNormalStyle = GoogleFonts.nunitoSans(
  fontSize: 14.0,
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
  fontWeight: FontWeight.w400,
);

final htDarkBlueLargeStyle = GoogleFonts.nunitoSans(
  fontSize: 16.0,
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
  fontWeight: FontWeight.w400,
);
const htLabelBlackStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontFamily: 'OpenSans',
    fontSize: 14);

final htBoldLabelStyle = GoogleFonts.nunitoSans(
  fontSize: 16.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const htSmallLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    fontFamily: 'OpenSans',
    fontSize: 10);
final htBlueTitleLabelStyle = TextStyle(
    color: ThemeManager.instance?.getCurrentTheme.colorTheme
        .darkBlueTextColor, //Color(0xFFFE9879
    fontWeight: FontWeight.bold,
    fontFamily: 'Domine',
    fontSize: 32);

final htBlueLabelStyle = TextStyle(
    color: ThemeManager.instance?.getCurrentTheme.colorTheme
        .openBlueTextColor, //Color(0xFFFE9879
    fontWeight: FontWeight.normal,
    fontFamily: 'NunitoSans',
    fontSize: 16);

const htTitleStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSansbold',
);
final htTitleStyle2 = GoogleFonts.domine(
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 32,
);

final htBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
