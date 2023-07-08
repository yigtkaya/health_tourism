import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/horizontal_space.dart';
import '../constants/theme/styles.dart';
import '../constants/vertical_space.dart';
import 'ht_text.dart';

class ValidationContainer extends StatefulWidget {
  final bool isPasswordLongEnough;
  final bool isPasswordContainsNumber;
  final bool isPasswordContainsUpperCase;

  const ValidationContainer(
      {Key? key,
      required this.isPasswordLongEnough,
      required this.isPasswordContainsNumber,
      required this.isPasswordContainsUpperCase})
      : super(key: key);

  @override
  State<ValidationContainer> createState() => _ValidationContainerState();
}

class _ValidationContainerState extends State<ValidationContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: widget.isPasswordLongEnough
                      ? Colors.green
                      : Colors.transparent,
                  border: widget.isPasswordLongEnough
                      ? Border.all(color: Colors.transparent)
                      : Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(50)),
              child: const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
            const HorizontalSpace(
              spaceAmount: 10,
            ),
            const HTText(
                label: "Contains at least 8 characters",
                style: htLabelBlackStyle)
          ],
        ),
        const VerticalSpace(
          spaceAmount: 10,
        ),
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: widget.isPasswordContainsNumber
                      ? Colors.green
                      : Colors.transparent,
                  border: widget.isPasswordContainsNumber
                      ? Border.all(color: Colors.transparent)
                      : Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(50)),
              child: const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
            const HorizontalSpace(
              spaceAmount: 10,
            ),
            const HTText(
              label: "Contains at least 1 number",
              style: htLabelBlackStyle,
            )
          ],
        ),
        const VerticalSpace(
          spaceAmount: 10,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: widget.isPasswordContainsUpperCase
                              ? Colors.green
                              : Colors.transparent,
                          border: widget.isPasswordContainsUpperCase
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    const HorizontalSpace(
                      spaceAmount: 10,
                    ),
                    const HTText(
                      label: "Contains at least 1 Upper case",
                      style: htLabelBlackStyle,
                    )
                  ],
                ),
        ),
      ],
    );
  }
}
