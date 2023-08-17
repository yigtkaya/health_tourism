import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_checkbox.dart';
import 'package:health_tourism/core/components/textfields/ht_password_field.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/components/textfields/ht_email_field.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/auth/auth_cubit.dart';
import 'package:health_tourism/product/theme/theme_manager.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // email address textField
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                height: size.height * 0.025,
                width: size.width * 0.025,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                HTText(label: "Welcome Back!", style: htTitleStyle2),
                const VerticalSpace(spaceAmount: 20),
                HTText(label: "Sign in to continue", style: htBlueLabelStyle),
                const VerticalSpace(spaceAmount: 30),
                HTEmailField(
                  onChanged: (value) {
                    updateEmail(value);
                  },
                  textController: emailController,
                ),
                const VerticalSpace(),
                HTPasswordField(
                    onChanged: (value) {
                      updatePassword(value);
                    },
                    textController: passController,
                    validation: false,
                    hintText: "Enter your password",
                    iconName: Icons.lock),
                const VerticalSpace(
                  spaceAmount: 20,
                ),
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
                      child: HTText(
                        label: "Forgot Password?",
                        style: htDarkBlueLargeStyle,
                      ),
                    ),
                  ],
                ),
                const VerticalSpace(spaceAmount: 40),
                GestureDetector(
                    onTap: () {
                      // check email is valid and password is not empty then sign in
                      BlocProvider.of<AuthCubit>(context)
                          .signInWithEmailAndPassword(email, password);
                      print("object");
                    },
                    child: signInButton(size)),
                const VerticalSpace(spaceAmount: 30),
                buildFooter(context),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContinueText(context),
                const VerticalSpace(
                  spaceAmount: 20,
                ),
                signInAlternatives(size, authCubit),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xFF123258),
                    ),
                    height: size.height * 0.006,
                    width: size.width * 0.4,
                  ),
                ),
              ],
            ),
          ],
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
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: HTText(
        label: "Sign In",
        style: htBoldLabelStyle,
      ),
    ),
  );
}

Widget buildContinueText(BuildContext context) {
  return HTText(
    label: "Sign in with social networks:",
    style: htBlueLabelStyle,
  );
}

Widget signInAlternatives(Size size, AuthCubit authCubit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      //sign in google button
      Expanded(
        child: GestureDetector(
          onTap: () {
            authCubit.signInWithGoogle();
            print("sign in google button tapped");
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0F5),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: HTIcon(
                iconName: AssetConstants.icons.googleIconPlus,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      ),
      const HorizontalSpace(),
      //sign in facebook button
      Expanded(
        child: GestureDetector(
          onTap: () {
            authCubit.signInWithFacebook();
            print("sign in facebook button tapped");
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0F5),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: HTIcon(
                iconName: AssetConstants.icons.facebookIconSimple,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      ),
      const HorizontalSpace(),
      Expanded(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0F5),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: HTIcon(
                iconName: AssetConstants.icons.twitter,
                width: 20,
                height: 20,
                color: ThemeManager.instance?.getCurrentTheme.colorTheme
                    .darkBlueTextColor,
              ),
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
          style: GoogleFonts.nunitoSans(
            fontSize: 14.0,
            color: ThemeManager
                .instance?.getCurrentTheme.colorTheme.openBlueTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextSpan(
          text: 'Sign up',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              goTo(path: RoutePath.register);
            },
          style: GoogleFonts.nunitoSans(
            fontSize: 16.0,
            color: ThemeManager
                .instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
