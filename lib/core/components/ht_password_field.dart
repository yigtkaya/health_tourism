import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/components/validation.dart';
import 'package:health_tourism/cubit/validation/validation_cubit.dart';
import 'package:health_tourism/cubit/validation/validation_state.dart';

import '../constants/asset.dart';
import '../constants/horizontal_space.dart';
import '../constants/theme/styles.dart';
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
    return BlocBuilder<ValidationCubit, ValidationState>(
      builder:(context, state) {
        return Column(
          children: [
            Container(
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
                    const HorizontalSpace(
                      spaceAmount: 12,
                    ),
                    //divider svg
                    HTIcon(iconName: AssetConstants.icons.verticalDivider, width: 20, height: 20 , color: Colors.white70,),
                    const HorizontalSpace(
                      spaceAmount: 16,
                    ),
                    //password textField
                    Expanded(
                      child:TextField(
                        maxLines: 1,
                        onChanged: widget.validation ? (value) {
                            widget.onChanged(value);
                        } : (value) {
                          widget.onChanged(value);
                        },
                        cursorColor: Colors.white70,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isSecure,
                        style: htLabelStyle,
                        decoration: InputDecoration(
                            suffixIcon: _isSecure ?  IconButton(
                              icon: const Icon(
                                Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isSecure = !_isSecure;
                                });
                              },

                            ) : IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isSecure = !_isSecure;
                                });
                              },
                            ),
                            hintText: widget.hintText,
                            hintStyle: htHintTextStyle,
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VerticalSpace(),
            !widget.validation ? const SizedBox.shrink() : ValidationContainer(
                isPasswordLongEnough: context.read<ValidationCubit>().state.isPasswordLongEnough,
                isPasswordContainsNumber: context.read<ValidationCubit>().state.hasOneNumber,
                isPasswordContainsUpperCase: context.read<ValidationCubit>().state.hasOneUpperCase,)
          ],
        );
      },
    );
  }
}
