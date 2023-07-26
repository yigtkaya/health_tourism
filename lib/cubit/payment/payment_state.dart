import 'package:flutter/cupertino.dart';
import 'package:health_tourism/product/models/iyzico_error.dart';

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
class PaymentStateLoadingState extends PaymentState {
  final CreditCardModel creditCardModel;
  const PaymentStateLoadingState(this.creditCardModel);
}

// create loaded state
class PaymentStateLoadedState extends PaymentState {
  const PaymentStateLoadedState();
}

// create error state
class PaymentStateErrorState extends PaymentState {
  final IyzicoError iyzicoError;
  const PaymentStateErrorState(this.iyzicoError);
}

