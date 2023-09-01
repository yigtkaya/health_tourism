import 'package:bloc/bloc.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';
import 'package:health_tourism/product/models/package.dart';
import 'package:health_tourism/product/repoImpl/payment_repo_impl.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentInitialState());

  PaymentRepoImpl paymentRepoImpl = PaymentRepoImpl();

  // create function to create payment
  Future<void> createPayment(
      String firstName,
      String surName,
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
      String cvc) async {
    emit(const PaymentLoadingState());
    await paymentRepoImpl.createPayment(firstName, surName, uid, price, cardHolderName,
        cardNumber, expireMonth, expireYear, zipcode, packageName, country, city, address, cvc);
    emit(const PaymentLoadedState());
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

class PackageCubit extends Cubit<Package?> {
  PackageCubit() : super(null);

  void selectPackage(Package package) => emit(package);
}