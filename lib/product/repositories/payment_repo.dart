abstract class PaymentRepository {
  Future<void> createPayment(String cardHolderName, String cardNumber,String expireMonth, String expireYear, String cvc);
  bool isCreditCardNumberValid(String cardNumber);
  bool isCreditCardExpireDateValid(String expireMonth, String expireYear);
  bool isAmexCard(String cardNumber);
}