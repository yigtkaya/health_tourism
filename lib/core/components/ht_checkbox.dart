import 'package:flutter/material.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/product/theme/theme_manager.dart';
import '../../product/theme/styles.dart';

class HTCheckBox extends StatefulWidget {
  // create checkbox text
  final String checkboxText;
  final bool isChecked;

  const HTCheckBox(
      {Key? key, required this.checkboxText, required this.isChecked})
      : super(key: key);

  @override
  State<HTCheckBox> createState() => _HTCheckBoxState();
}

class _HTCheckBoxState extends State<HTCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: const Color(0xFFDDE3F1),
              width: 2.0,
            ),
            color: Colors.white,
          ),
          child: widget.isChecked
              ? HTIcon(
            iconName: AssetConstants.icons.checkMark,
            width: 16,
            height: 16,
            color: ThemeManager.instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
          ) : const SizedBox(),
        ),
        const HorizontalSpace(
          spaceAmount: 7,
        ),
        Text(
          widget.checkboxText,
          style: htBlueLabelStyle,
        ),
      ],
    );
  }
}
