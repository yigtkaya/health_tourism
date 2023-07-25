import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState {
  final PaymentStatus status;
  final CardFieldInputDetails card;

  const PaymentState(
      {this.status = PaymentStatus.initial,
      this.card = const CardFieldInputDetails(complete: false)});

  PaymentState copywtih({PaymentStatus? status, CardFieldInputDetails? card}) {
    return PaymentState(status: status ?? this.status, card: card ?? this.card);
  }

  @override
  List<Object?> get props => [status, card];
}
