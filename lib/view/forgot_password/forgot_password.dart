import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_email_field.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/auth/auth_cubit.dart';
import 'package:health_tourism/product/theme/theme_manager.dart';
import '../../product/navigation/route_paths.dart';
import '../../product/navigation/router.dart';
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff2D9CDB),
                ),
                height: size.height * 0.08,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HTIcon(iconName: AssetConstants.icons.chevronLeft),
                      const Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: HTText(
                            label: "Forgot Password", style: htBoldLabelStyle),
                      )),
                    ],
                  ),
                ),
              ),
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
                          hintText: "Enter your email address",
                          iconName: Icons.mail_rounded),
                      const VerticalSpace(
                        spaceAmount: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          // check email is valid and password is not empty then sign in
                          BlocProvider.of<AuthCubit>(context)
                              .passwordResetSubmit(email);
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

Widget sendButton(Size size) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xFF58A2EB),
      ),
      width: double.infinity,
      height: size.height * 0.06,
      child: const Center(
        child: HTText(
          label: "Send",
          style: htBoldLabelStyle,
        ),
      ));
}
