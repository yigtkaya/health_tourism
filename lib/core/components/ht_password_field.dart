import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/components/ht_validation.dart';
import 'package:health_tourism/cubit/validation/validation_cubit.dart';
import 'package:health_tourism/cubit/validation/validation_state.dart';

import '../../product/theme/styles.dart';
import '../../product/theme/theme_manager.dart';
import '../constants/asset.dart';
import '../constants/dimen.dart';
import '../constants/horizontal_space.dart';
import '../constants/vertical_space.dart';
import 'ht_icon.dart';

class HTPasswordField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final bool validation;
  final Function(String) onChanged;
  final IconData iconName;

  const HTPasswordField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.iconName,
    required this.onChanged,
    required this.validation,
  }) : super(key: key);

  @override
  State<HTPasswordField> createState() => _HTPasswordFieldState();
}

class _HTPasswordFieldState extends State<HTPasswordField> {
  bool _isSecure = true;

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
                  widget.onChanged(value);
                },
                cursorColor: ThemeManager.instance?.getCurrentTheme.colorTheme
                    .darkBlueTextColor,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isSecure,
                style: htDarkBlueNormalStyle,
                decoration: InputDecoration(
                    hintText: "••••••••",
                    hintStyle: htHintTextStyle,
                    border: InputBorder.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _isSecure
                  ? HTIcon(
                      iconName: AssetConstants.icons.visibilityOff,
                      width: 24,
                      height: 24,
                      color: const Color(0xFF123258),
                      onPress: () {
                        _togglePasswordView();
                      },
                    )
                  : HTIcon(
                      iconName: AssetConstants.icons.visibilityOn,
                      width: 24,
                      height: 24,
                      onPress: () {
                        _togglePasswordView();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isSecure = !_isSecure;
    });
  }
}
