import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/view/bottom_navigation/bottom_navigation.dart';
import 'package:health_tourism/view/login/login_view.dart';
import 'package:health_tourism/view/payment/payment_view.dart';
import '../../cubit/auth/AuthState.dart';
import '../../cubit/auth/auth_cubit.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return PaymentView();
          }
          return const PaymentView();
        });
  }
}
