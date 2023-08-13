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
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/auth/auth_cubit.dart';
import '../../product/navigation/route_paths.dart';
import '../../product/navigation/router.dart';
import '../../core/components/ht_icon.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/dimen.dart';
import '../../product/theme/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isChecked = false;
  String email = '';
  String password = '';

  final authCubit = AuthCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void updateEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void updatePassword(String value) {
    setState(() {
      password = value;
    });
  }

  bool isEnabled() {
    if (EmailValidator.validate(emailController.text) &&
        passController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF81A1C8),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HTText(label: "Welcome Back!", style: htBlueTitleLabelStyle),
              const HTText(
                  label: "Sign in to continue", style: htBlueLabelStyle),
              // email address textField
              Column(
                children: [
                  HTEmailField(
                      onChanged: (value) {
                        updateEmail(value);
                      },
                      textController: emailController,
                      hintText: "Enter your email address",
                      iconName: Icons.mail_rounded),
                  const VerticalSpace(),
                  HTPasswordField(
                      onChanged: (value) {
                        updatePassword(value);
                      },
                      textController: passController,
                      validation: false,
                      hintText: "Enter your password",
                      iconName: Icons.lock),
                  const VerticalSpace(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: HTCheckBox(
                          checkboxText: "Remember me",
                          isChecked: isChecked,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          pushTo(path: RoutePath.forgotPassword);
                        },
                        child: const HTText(
                          label: "Forgot Password?",
                          style: htDarkBlueLargeStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            // check email is valid and password is not empty then sign in
                            BlocProvider.of<AuthCubit>(context)
                                .signInWithEmailAndPassword(email, password);
                            print("object");
                          },
                          child: signInButton(size)),
                      const VerticalSpace(
                        spaceAmount: DimenConstant.VERY_LARGE,
                      ),
                      buildContinueText(context),
                    ],
                  )),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        signInGoogleFacebookButton(size, authCubit),
                        const Spacer(),
                        buildFooter(context),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}

Widget signInButton(Size size) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: const Color(0xFF58A2EB),
    ),
    child: const Padding(
      padding: EdgeInsets.symmetric(vertical: 13.0),
      child: HTText(
        label: "Sign In",
        style: htDarkBlueNormalStyle,
      ),
    ),
  );
}

Widget buildContinueText(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      const Expanded(
          child: Divider(
        color: Colors.white,
      )),
      Expanded(child: HTText.labelMedium("Or Continue with", context: context)),
      const Expanded(
          child: Divider(
        color: Color(0xFFE5E5E5),
      )),
    ],
  );
}

Widget signInGoogleFacebookButton(Size size, AuthCubit authCubit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      //sign in google button
      GestureDetector(
        onTap: () {
          authCubit.signInWithGoogle();
          print("sign in google button tapped");
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon of google
                HTIcon(
                  iconName: AssetConstants.icons.googleIcon,
                  width: 28,
                  height: 28,
                ),
                const HorizontalSpace(),
                //google txt
                const Text(
                  'Google',
                  style: htDarkBlueNormalStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      const HorizontalSpace(),
      //sign in facebook button
      GestureDetector(
        onTap: () {
          authCubit.signInWithFacebook();
          print("sign in facebook button tapped");
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //facebook icon
                HTIcon(
                  iconName: AssetConstants.icons.facebookIcon,
                  width: 28,
                  height: 28,
                ),
                const HorizontalSpace(),
                //facebook txt
                const Text(
                  'Facebook',
                  textAlign: TextAlign.center,
                  style: htDarkBlueNormalStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildFooter(BuildContext context) {
  return Text.rich(
    TextSpan(
      style: htDarkBlueNormalStyle,
      children: [
        TextSpan(
          text: 'Don’t have account? ',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: 'Sign up',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              goTo(path: RoutePath.register);
            },
          style: GoogleFonts.nunito(
            color: const Color(0xFFEF8733),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
