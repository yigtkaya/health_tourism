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
class PaymentLoadedState extends PaymentState {
  const PaymentLoadedState();
}

// create error state
class PaymentErrorState extends PaymentState {
  final IyzicoError iyzicoError;
  const PaymentErrorState(this.iyzicoError);
}

class SelectedPackage extends PaymentState {
  final Package package;
  const SelectedPackage(this.package);
}
