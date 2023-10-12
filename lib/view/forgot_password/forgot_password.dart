import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/textfields/ht_email_field.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/auth/auth_cubit.dart';
import '../../core/components/ht_icon.dart';
import '../../core/constants/asset.dart';
import '../../product/theme/styles.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController emailController = TextEditingController();
  String email = '';
  final authCubit = AuthCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void updateEmail(String value) {
    setState(() {
      email = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: const Color(0xff2D9CDB),
        elevation: 0,
        centerTitle: true,
        title: HTText(
          label: "Forgot Password",
          style: htToolBarLabel,
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  HTText(
                      label:
                          " Please enter your email address. You will receive a link to create a new password via email.",
                      style: htBlueLabelStyle),
                  const VerticalSpace(
                    spaceAmount: 30,
                  ),
                  HTEmailField(
                    onChanged: (value) {
                      updateEmail(value);
                    },
                    textController: emailController,
                  ),
                  const VerticalSpace(
                    spaceAmount: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      // check email is valid and password is not empty then sign in

                      BlocProvider.of<AuthCubit>(context)
                          .passwordResetSubmit(email);

                      emailController.clear();
                    },
                    child: sendButton(size),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

Widget sendButton(Size size) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xFF58A2EB),
      ),
      width: double.infinity,
      height: size.height * 0.06,
      child: Center(
        child: HTText(
          label: "Send",
          style: htBoldLabelStyle,
        ),
      ));
}

