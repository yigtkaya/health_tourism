import 'package:bloc/bloc.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';
import 'package:health_tourism/product/repoImpl/payment_repo_impl.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentInitialState());

  PaymentRepoImpl paymentRepoImpl = PaymentRepoImpl();

  // create function to create payment
  Future<void> createPayment(String cardHolderName, String cardNumber, String expireMonth, String expireYear, String cvc) async {
      emit(const PaymentStateLoadingState());
      await paymentRepoImpl.createPayment(cardHolderName, cardNumber, expireMonth, expireYear, cvc);
      emit(const PaymentStateLoadedState());
  }
  // create function to validate credit card number
  bool isCreditCardNumberValid(String cardNumber) {
    return paymentRepoImpl.isCreditCardNumberValid(cardNumber);
  }
  // create function to validate credit card expire date
  bool isCreditCardExpireDateValid(String expireMonth, String expireYear) {
    return paymentRepoImpl.isCreditCardExpireDateValid(expireMonth, expireYear);
  }
  // create function to validate amex card
  bool isAmexCard(String cardNumber) {
    return paymentRepoImpl.isAmexCard(cardNumber);
  }
}