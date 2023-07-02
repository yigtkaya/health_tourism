import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/theme/styles.dart';

class HTPasswordField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData iconName;

  const HTPasswordField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.iconName,
  }) : super(key: key);

  @override
  State<HTPasswordField> createState() => _HTPasswordFieldState();
}

class _HTPasswordFieldState extends State<HTPasswordField> {
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
            //lock logo here
            const Icon(
              Icons.lock,
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

            //password textField
            Expanded(
              child:TextField(
                maxLines: 1,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                style: htLabelStyle,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.visibility,
                    color: Colors.white70,
                  ),
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
