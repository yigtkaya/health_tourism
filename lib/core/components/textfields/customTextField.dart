import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/dimen.dart';
import 'package:health_tourism/product/theme/theme_manager.dart';

import '../../../product/theme/styles.dart';

class HTCustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final Function(String) onChanged;

  const HTCustomTextField({
    Key? key,
    required this.textController,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<HTCustomTextField> createState() => _HTCustomTextFieldState();
}

class _HTCustomTextFieldState extends State<HTCustomTextField> {
  bool _isValid = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimenConstant.SMALL),
        border: Border.all(color: const Color(0xFFD3E3F1), width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //email address textField
            Expanded(
              child: TextFormField(
                maxLines: 1,
                onChanged: (value) {
                  checkIfEmpty(value);
                  widget.onChanged(value);
                },
                cursorColor: ThemeManager.instance?.getCurrentTheme.colorTheme
                    .darkBlueTextColor,
                keyboardType: TextInputType.emailAddress,
                style: htDarkBlueNormalStyle,
                decoration: InputDecoration(
                    hintText: "John Doe",
                    hintStyle: htHintTextStyle,
                    border: InputBorder.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _isValid
                  ? HTIcon(
                iconName: AssetConstants.icons.checkMark,
                width: 22,
                height: 22,
                color: ThemeManager.instance?.getCurrentTheme.colorTheme
                    .darkBlueTextColor,
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  void checkIfEmpty(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _isValid = true;
      });
    } else {
      setState(() {
        _isValid = false;
      });
    }
  }
}
