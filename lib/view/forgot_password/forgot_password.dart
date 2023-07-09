import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_checkbox.dart';
import 'package:health_tourism/core/components/ht_password_field.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/components/ht_email_field.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/core/constants/theme/styles.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/auth/auth_cubit.dart';
import '../../product/navigation/router.dart';
import '../../core/components/ht_icon.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/dimen.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF81A1C8),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BackButton(
                    color: Colors.white,
                    onPressed: () {
                      goTo(path: RoutePath.signIn);
                    },
                  ),
                  Expanded(child: loginTitle()),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF9EB9D2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text.rich(
                      TextSpan(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          children: [
                            WidgetSpan(
                                child: HTIcon(
                              iconName: AssetConstants.icons.infoIcon,
                              color: Colors.white,
                              width: 16,
                              height: 16,
                            )),
                            const TextSpan(
                                text:
                                    " Type email address you used to register. We will send you an email with your username and a link to reset your password.")
                          ]),
                    ),
                  )),
              const VerticalSpace(),
              HTEmailField(
                  onChanged: (value) {
                    updateEmail(value);
                  },
                  textController: emailController,
                  hintText: "Enter your email address",
                  iconName: Icons.mail_rounded),
              const VerticalSpace(),
              GestureDetector(
                onTap: () {
                  // check email is valid and password is not empty then sign in
                  BlocProvider.of<AuthCubit>(context)
                      .passwordResetSubmit(email);
                  print("object");
                },
                child: signInButton(),
              ),
              const VerticalSpace(
                spaceAmount: DimenConstant.VERY_LARGE,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

Widget loginTitle() {
  return Text.rich(
    TextSpan(
      style: GoogleFonts.inter(
        fontSize: 24,
        color: Colors.white,
        letterSpacing: 1.8,
      ),
      children: const [
        TextSpan(
          text: 'RESET',
          style: htTitleStyle,
        ),
        TextSpan(text: 'PAGE', style: htTitleStyle2),
      ],
    ),
  );
}

Widget signInButton() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xFFEF8733),
    ),
    child: const Padding(
      padding: EdgeInsets.all(18.0),
      child: Text(
        'Send Email',
        style: htBoldLabelStyle,
      ),
    ),
  );
}
