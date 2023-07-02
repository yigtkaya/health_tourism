import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/theme/styles.dart';

class HTEmailField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData iconName;

  const HTEmailField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.iconName,
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
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF9EB9D2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //mail icon
            Icon(
              widget.iconName,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 12,
            ),
            //divider svg
            SvgPicture.asset(
              'assets/images/vertical_divider.svg',
            ),
            const SizedBox(
              width: 16,
            ),

            //email address textField
            Expanded(
              child: TextField(
                maxLines: 1,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.emailAddress,
                style: htLabelStyle,
                decoration: InputDecoration(
                    hintText: widget.hintText,
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
