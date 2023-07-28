
import '../models/buyer.dart';
import '../models/package.dart';

abstract class PaymentRepository {
  Future<void> createPayment(Map package,Map buyer, double price, String cardHolderName, String cardNumber,String expireMonth, String expireYear, String cvc);
  bool isCreditCardNumberValid(String cardNumber);
  bool isCreditCardExpireDateValid(String expireMonth, String expireYear);
  bool isAmexCard(String cardNumber);
}
