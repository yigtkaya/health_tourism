abstract class PaymentRepository {
  Future<Map<dynamic, dynamic>> createPayment(
      String firstName,
      String surName,
      String uid,
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
      String cvc);
  bool isCreditCardNumberValid(String cardNumber);
  bool isCreditCardExpireDateValid(String expireMonth, String expireYear);
  bool isAmexCard(String cardNumber);
}
