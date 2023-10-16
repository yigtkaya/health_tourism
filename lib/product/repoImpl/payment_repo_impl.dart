import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:health_tourism/product/repositories/payment_repo.dart';

class PaymentRepoImpl extends PaymentRepository {
  final dio = Dio();

  @override
  Future<Map<dynamic, dynamic>> createPayment(
      String firstName,
      String surName,
      String uid,
      String email,
      Map appointment,
      double price,
      String cardHolderName,
      String cardNumber,
      String expireMonth,
      String expireYear,
      String zipcode,
      String packageName,
      String address,
      String country,
      String city,
      String cvc) async {

    // make request to firebase function with dio package
    final result = await dio.post(
      'http://10.0.2.2:3000/api/iyzico/pay',
      data: {
        'contactName': '$firstName $surName',
        'uid': uid,
        'city': city,
        'surName': surName,
        'country': country,
        'address': address,
        'email': email,
        'price': price,
        'cardHolderName': cardHolderName,
        'cardNumber': cardNumber,
        'expireMonth': expireMonth,
        'expireYear': expireYear,
        'cvc': cvc,
        'zipcode': zipcode,
        'packageName': packageName
      },
    );
    final jsonString = json.encode(result.data);
    final map = jsonDecode(jsonString);

    return map;
  }

  @override
  bool isCreditCardNumberValid(String cardNumber) {
    if (cardNumber.isEmpty) return false;

    int sum = 0;
    bool isDouble = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (isDouble) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      isDouble = !isDouble;
    }

    return sum % 10 == 0;
  }

  @override
  bool isCreditCardExpireDateValid(String expireMonth, String expireYear) {
    if (expireMonth.isEmpty || expireYear.isEmpty) return false;

    int month = int.parse(expireMonth);
    int year = int.parse(expireYear);

    if (month < 1 || month > 12) return false;

    DateTime now = DateTime.now();
    int currentYear = now.year % 100;

    if (year < currentYear) return false;

    if (year == currentYear && month < now.month) return false;

    return true;
  }

  @override
  bool isAmexCard(String cardNumber) {
    if (cardNumber.isEmpty) return false;

    String prefix = cardNumber.substring(0, 2);
    if (cardNumber.length == 15 && (prefix == '34' || prefix == '37')) {
      return true;
    }
    return false;
  }
}
