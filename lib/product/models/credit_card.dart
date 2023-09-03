// create credit card model
import 'package:flutter/material.dart';

class CreditCardModel {
  final String cardNumber;
  final String expireMonth;
  final String expireYear;
  final String cvc;
  final String cardHolderName;

  CreditCardModel({
    required this.cardNumber,
    required this.expireMonth,
    required this.expireYear,
    required this.cvc,
    required this.cardHolderName,
  });
}