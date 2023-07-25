import 'package:bloc/bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState()) {
    emit(state.copywtih(status: PaymentStatus.initial));
  }

  void createPayment() async {
    try {
      emit(state.copywtih(status: PaymentStatus.loading));
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(email: ""),
          ),
        ),
      );
    } catch (e) {
      emit(state.copywtih(status: PaymentStatus.failure));
    }
  }
}
