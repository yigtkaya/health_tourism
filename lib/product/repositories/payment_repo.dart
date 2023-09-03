abstract class PaymentRepository {
  Future<Map<dynamic, dynamic>> createPayment(
      String surName,
      String firstName,
      String uid,
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
      String cvc);
  bool isCreditCardNumberValid(String cardNumber);
  bool isCreditCardExpireDateValid(String expireMonth, String expireYear);
  bool isAmexCard(String cardNumber);
}
