import 'package:flutter/material.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/navigation/router.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../cubit/payment/payment_state.dart';
import '../../product/theme/styles.dart';

class SuccessView extends StatefulWidget {
  final PaymentSuccessState state;
  const SuccessView({super.key, required this.state});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {

  @override
  void initState() {
    super.initState();
  }
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
            "\$${widget.state.response["price"]} paid successfully, Your reservation is created.",
            style: htLabelBlackStyle),
      ],
    );
  }
}
