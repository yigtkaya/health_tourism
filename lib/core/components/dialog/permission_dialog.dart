import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/product/theme/styles.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatelessWidget {
  final String title, content;

  const PermissionDialog(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: HTText(
        label: title,
        style: htDarkBlueLargeStyle,
      ),
      content: HTText(
        label: content,
        style: htBlueLabelStyle,
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            context.pop();
          },
          child: HTText(
            label: "Cancel",
            style: htDarkBlueLargeStyle,
          ),
        ),
        CupertinoDialogAction(
          onPressed: () async {
            final bool = await openAppSettings();
            context.pop();
          },
          child: HTText(
            label: "Allow",
            style: htDarkBlueLargeStyle,
          ),
        ),
      ],
    );
  }
}
