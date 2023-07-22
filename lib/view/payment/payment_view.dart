import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("CARD DATA FORM DENEME"),
              const VerticalSpace(),
              CardFormField(
                controller: CardFormEditController(),
              ),
              const VerticalSpace(),
              ElevatedButton(onPressed: () {

              }, child: const Text("PAY"),)
            ],
          ),),
    );
  }
}
