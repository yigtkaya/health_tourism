import 'package:flutter/material.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/navigation/router.dart';
import '../../core/components/ht_text.dart';
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
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset("assets/images/payment_success.png"),
          const Spacer(),
          HTText(label: "Reservation Complete!", style: htTitleStyle),
          const Spacer(),
          Text(
            textAlign: TextAlign.center,
            "Your appointment has been created successfully.",
            style: htDarkBlueNormalStyle.copyWith(fontSize: 16),
          ),
          const Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              goTo(path: RoutePath.bottomNavigation);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  height: size.height * 0.06,
                  decoration: const BoxDecoration(
                    color: Color(0xff58a2eb),
                  ),
                  child: Center(
                    child: HTText(label: 'Done', style: htBoldLabelStyle),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
