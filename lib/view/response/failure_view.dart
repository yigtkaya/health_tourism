import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';
import '../../core/components/ht_text.dart';
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
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset("assets/images/payment_fail.png"),
          const Spacer(),
          HTText(label: "Reservation Unsuccessful!", style: htTitleStyle),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
                textAlign: TextAlign.center,
                "Appointment booking unsuccessful. Please try again later.",
                style: htDarkBlueNormalStyle.copyWith(
                  fontSize: 16
                ),),
          ),
          const Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  height: size.height * 0.06,
                  decoration: const BoxDecoration(
                    color: Color(0xff58a2eb),
                  ),
                  child: Center(
                    child: HTText(
                        label: 'Try Again', style: htBoldLabelStyle),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
