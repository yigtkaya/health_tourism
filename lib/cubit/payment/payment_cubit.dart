import 'package:bloc/bloc.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';
import 'package:health_tourism/product/models/package.dart';
import 'package:health_tourism/product/repoImpl/payment_repo_impl.dart';
import 'package:health_tourism/product/repoImpl/user_%20repo_impl.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentInitialState());

  PaymentRepoImpl paymentRepoImpl = PaymentRepoImpl();
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();

  void setState() => emit(const PaymentInitialState());

  // create function to create payment
  Future<void> createPayment(
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
      String cvc) async {
    try {
      emit(const PaymentLoadingState());
      final response = await paymentRepoImpl.createPayment(
          firstName,
          surName,
          uid,
          appointment,
          price,
          cardHolderName,
          cardNumber,
          expireMonth,
          expireYear,
          zipcode,
          packageName,
          country,
          city,
          address,
          cvc);

      userRepositoryImpl.createAppointment(uid, appointment);

      if (response["status"] == "failure") {
        emit(
            PaymentErrorState(response["errorMessage"], response["errorCode"]));
        return;
      }
      emit(PaymentSuccessState(response));
    } catch (e) {
      emit(const PaymentErrorState(
          "A bad request made. Please try again later.", "101"));
    }
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

  void addAppointmentToFirebase(String uid, Map appointment) {
      userRepositoryImpl.createAppointment(uid, appointment);
  }
}

class PackageCubit extends Cubit<Package?> {
  PackageCubit() : super(null);

  void selectPackage(Package package) => emit(package);
}
