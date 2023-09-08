import 'package:flutter/material.dart';

import '../../../product/theme/styles.dart';
import '../../constants/vertical_space.dart';
import '../ht_text.dart';

class LeaveCommentDialog extends StatelessWidget {
  final TextEditingController commentController;

  const LeaveCommentDialog({super.key, required this.commentController});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextEditingController _commentController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/review_dialog.png",
                width: size.width * 0.8,
                height: size.height * 0.2,
              ),
              const VerticalSpace(
                spaceAmount: 24,
              ),
              Text(
                "Please Rate The Quality of Service!",
                style: htTitleStyle,
                textAlign: TextAlign.center,
              ),
              const VerticalSpace(
                spaceAmount: 16,
              ),
              // yıldızlar buraya gelecek.
              Text(
                  "Your comments and suggestions help us improve the service quality better!",
                  style: htBlueLabelStyle,
                  textAlign: TextAlign.center),
              const VerticalSpace(
                spaceAmount: 24,
              ),
              Container(
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFFD3E3F1).withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    maxLines: 5,
                    controller: commentController,
                    style: htDarkBlueNormalStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your comment",
                      hintStyle: htHintTextStyle,
                    ),
                  ),
                ),
              ),
              const VerticalSpace(
                spaceAmount: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF58A2EB),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HTText(
                      label: "Submit",
                      style: htBoldLabelStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), //this right here
    );
  }
}
