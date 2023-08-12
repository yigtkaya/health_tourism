import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/dimen.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';

import '../../product/theme/styles.dart';

class HTEmailField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String) onChanged;
  final IconData iconName;

  const HTEmailField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.iconName,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<HTEmailField> createState() => _HTEmailFieldState();
}

class _HTEmailFieldState extends State<HTEmailField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimenConstant.SMALL),
        border: Border.all(color: const Color(0xFFD3E3F1), width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12.0),
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
                cursorColor: Colors.white70,
                keyboardType: TextInputType.emailAddress,
                style: htLabelStyle,
                decoration: const InputDecoration(
                    hintText: "example@mail.com",
                    hintStyle: htHintTextStyle,
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
