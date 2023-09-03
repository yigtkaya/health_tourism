import 'package:flutter/cupertino.dart';
import 'package:health_tourism/product/models/iyzico_error.dart';
import 'package:health_tourism/product/models/package.dart';

import '../../product/models/credit_card.dart';

@immutable
abstract class PaymentState {
  const PaymentState();
}
// create initial state
class PaymentInitialState extends PaymentState {
  const PaymentInitialState();
}

// create loading state
class PaymentLoadingState extends PaymentState {
  const PaymentLoadingState();
}

// create loaded state
class PaymentSuccessState extends PaymentState {
  final Map response;
  const PaymentSuccessState(this.response);
}

// create error state
class PaymentErrorState extends PaymentState {
  final String error;
  final String errorCode;
  const PaymentErrorState(this.error, this.errorCode);
}
