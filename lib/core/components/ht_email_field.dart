import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import '../constants/theme/styles.dart';

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
            const HorizontalSpace(
              spaceAmount: 10,
            ),
            //divider svg
            HTIcon(iconName: AssetConstants.icons.verticalDivider, width: 20, height: 20 , color: Colors.white70,),
            const SizedBox(
              width: 16,
            ),

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
