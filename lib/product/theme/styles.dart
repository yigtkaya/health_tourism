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
final htDarkBlueBoldLargeStyle = GoogleFonts.nunitoSans(
  fontSize: 16.0,
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
  fontWeight: FontWeight.w600,
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

final htToolBarLabel = GoogleFonts.nunitoSans(
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

final htSmallLabelStyle = GoogleFonts.nunitoSans(
  fontSize: 12.0,
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.openBlueTextColor,
  fontWeight: FontWeight.normal,
);
final htBlueTitleLabelStyle = GoogleFonts.domine(
  fontSize: 32.0,
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.openBlueTextColor,
  fontWeight: FontWeight.bold,
);

final htBlueLabelStyle = GoogleFonts.nunitoSans(
  fontSize: 16.0,
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.openBlueTextColor,
  fontWeight: FontWeight.normal,
);

final htOnboardingSubTitle = GoogleFonts.domine(
  fontSize: 18.0,
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.openBlueTextColor,
  fontWeight: FontWeight.normal,
);
final htSubTitle = GoogleFonts.domine(
  fontSize: 18.0,
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
  fontWeight: FontWeight.bold,
);
final htTitleStyle = GoogleFonts.domine(
  color: ThemeManager.instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
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
