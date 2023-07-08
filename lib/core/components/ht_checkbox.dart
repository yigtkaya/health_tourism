import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';

import '../constants/theme/styles.dart';

class HTCheckBox extends StatefulWidget {
  // create checkbox text
  final String checkboxText;

  const HTCheckBox({Key? key, required this.checkboxText}) : super(key: key);

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
          width: 17.0,
          height: 17.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: const Color(0xFF9AD5D1),
          ),
          child: SvgPicture.asset(
            'assets/images/checkbox.svg',
          ),
        ),
        const HorizontalSpace(),
        Text(
          widget.checkboxText,
          style: htLabelStyle,
        ),
      ],
    );
  }
}
