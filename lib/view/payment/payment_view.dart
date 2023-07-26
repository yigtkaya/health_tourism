import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:health_tourism/cubit/payment/payment_cubit.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  var cardNumber = '';
  var expiryDate = '';
  var cardHolderName = '';
  var cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>>? cardNumberKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormState> cvvCodeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> expiryDateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> cardHolderKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
      if(state is PaymentStateLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is PaymentStateLoadedState) {
          return const Center(child: Text("Payment is successful"));
        }
        else if (state is PaymentStateErrorState) {
          return const Center(child: Text("Payment is failed"));
        }
        else {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.07),
                child: Column(
                  children: [
                    CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      isHolderNameVisible: true,
                      showBackView: isCvvFocused,
                      onCreditCardWidgetChange:
                          (CreditCardBrand) {}, //true when you want to show cvv(back) view
                    ),
                    CreditCardForm(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      cardNumberKey: cardNumberKey,
                      formKey: formKey, // Required
                      onCreditCardModelChange: (CreditCardModel data) {
                        setState(() {
                          if (data.cvvCode.length <= 3) {
                            cvvCode = data.cvvCode;
                          }
                          cardNumber = data.cardNumber;
                          expiryDate = data.expiryDate;
                          cardHolderName = data.cardHolderName;
                          isCvvFocused = data.isCvvFocused;
                        });
                      }, // Required
                      themeColor: Colors.red,
                      obscureCvv: true,
                      obscureNumber: true,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      enableCvv: true,
                      cardNumberValidator: (String? cardNumber) {},
                      expiryDateValidator: (String? expiryDate) {},
                      cvvValidator: (String? cvv) {
                        if (cvv!.isEmpty) {
                          return 'Empty';
                        }
                        if (cvv.length < 3) {
                          return 'Too short';
                        }
                        return null;
                      },
                      cardHolderValidator: (String? cardHolderName) {},
                      onFormComplete: () {
                        // callback to execute at the end of filling card data
                      },
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Holder',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          if (cardNumber.length == 19 &&
                              expiryDate.length == 5 &&
                              cardHolderName.isNotEmpty &&
                              cvvCode.length == 3) {
                            print("Valid");
                            cardNumber = cardNumber.replaceAll(" ", "");
                            var expireMonth = expiryDate.split("/")[0];
                            var expireYear = "20${expiryDate.split("/")[1]}";
                            // return fonksionu
                          } else {
                            print("Invalid");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: width,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.pink,
                          ),
                          child: const Text("Pay"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }

    });
  }
}
