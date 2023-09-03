import 'package:flutter/material.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';

import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../product/navigation/router.dart';
import '../../product/theme/styles.dart';

class FailureView extends StatefulWidget {
  final PaymentErrorState state;
  const FailureView({super.key, required this.state});

  @override
  State<FailureView> createState() => _FailureViewState();
}

class _FailureViewState extends State<FailureView> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      goBack();
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HTIcon(
          iconName: AssetConstants.icons.success,
          height: 40,
        ),
        HTText(
            label:
                "${widget.state.error} error occurred with code: ${widget.state.errorCode}",
            style: htLabelBlackStyle),
      ],
    );
  }
}
