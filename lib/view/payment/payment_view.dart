import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:health_tourism/cubit/payment/payment_cubit.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';
import 'package:health_tourism/product/models/package.dart';

import '../../product/models/buyer.dart';

class PaymentView extends StatefulWidget {
  Buyer? buyer;
  Package? package;
  double? price;

  PaymentView(this.buyer, this.package, this.price, {super.key});

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
      if (state is PaymentLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is PaymentLoadedState) {
        return const Center(child: Text("Payment is successful"));
      } else if (state is PaymentErrorState) {
        return const Center(child: Text("Payment is failed"));
      } else {
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
                        onTap: () async {
                          print("object");

                          var expireMonth = expiryDate.split('/')[0];
                          var expireYear = '20${expiryDate.split('/')[1]}';
                          cardNumber = cardNumber.replaceAll(' ', '');
                          var buyer = {
                            'id': "01",
                            'name': "yiğit",
                            'surname': "kAYA",
                            'email': "hasanyigtkaya@gmail.com",
                            'city': "istanbul",
                            'country': "Turkiye",
                            'address': "umraniye",
                          };
                          var package = {
                            'id': "widget.package!.id",
                            'name': "widget.package!.name",
                            'category': "widget.package!.category",
                            'price': 1.5,
                          };
                          // check if credit card is amex card
                          if (context
                              .read<PaymentCubit>()
                              .isAmexCard(cardNumber)) {
                            // check if credit card model is valid
                            if (context
                                .read<PaymentCubit>()
                                .isCreditCardExpireDateValid(
                                    expireMonth, expireYear)) {
                              context.read<PaymentCubit>().createPayment(
                                  package,
                                  buyer,
                                  widget.package!.price,
                                  cardHolderName,
                                  cardNumber,
                                  expireMonth,
                                  expireYear,
                                  cvvCode);
                            }
                          } else {
                            if (context
                                    .read<PaymentCubit>()
                                    .isCreditCardExpireDateValid(
                                        expireMonth, expireYear) &&
                                context
                                    .read<PaymentCubit>()
                                    .isCreditCardNumberValid(cardNumber)) {
                              context.read<PaymentCubit>().createPayment(
                                  package,
                                  buyer,
                                  1.2,
                                  cardHolderName,
                                  cardNumber,
                                  expireMonth,
                                  expireYear,
                                  cvvCode);
                            }
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
