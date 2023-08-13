import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_password_field.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/components/ht_email_field.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/auth/auth_cubit.dart';
import '../../product/navigation/route_paths.dart';
import '../../product/navigation/router.dart';
import '../../core/components/ht_icon.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/dimen.dart';
import '../../product/theme/styles.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confPassController = TextEditingController();
  String email = '';
  String password = '';
  String confPassword = '';

  final authCubit = AuthCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confPassController.dispose();
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

  void updateConfPassword(String value) {
    setState(() {
      confPassword = value;
    });
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
              Expanded(
                flex: 3,
                child: loginTitle(),
              ),
              const Expanded(
                  flex: 1,
                  child: HTText(
                      label: "Continue with email for sign up App",
                      style: htDarkBlueNormalStyle)),
              // email address textField
              Expanded(
                  flex: 6,
                  child: Column(
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
                          validation: false,
                          textController: passController,
                          hintText: "Enter your password",
                          iconName: Icons.lock),
                      HTPasswordField(
                          onChanged: (value) {
                            updateConfPassword(value);
                          },
                          validation: false,
                          textController: passController,
                          hintText: "Enter your password",
                          iconName: Icons.lock),
                      const VerticalSpace(),
                    ],
                  )),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            try {
                              context
                                  .read<AuthCubit>()
                                  .signUpWithEmailAndPassword(email, password);
                            } on Exception catch (e) {
                              print(e.toString());
                            }
                          },
                          child: signUpButton(size)),
                      const VerticalSpace(
                        spaceAmount: DimenConstant.VERY_LARGE,
                      ),
                      buildContinueText(),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        signInGoogleFacebookButton(size),
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
          text: 'SIGNUP',
          style: htTitleStyle,
        ),
        TextSpan(text: 'PAGE', style: htTitleStyle2),
      ],
    ),
  );
}

Widget signUpButton(Size size) {
  return Container(
    alignment: Alignment.center,
    height: size.height / 13,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xFFEF8733),
    ),
    child: const Text(
      'Sign up',
      style: htBoldLabelStyle,
    ),
  );
}

Widget buildContinueText() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Expanded(
          child: Divider(
        color: Colors.white,
      )),
      Expanded(
        child: Text(
          'Or Continue with',
          style: htDarkBlueNormalStyle,
          textAlign: TextAlign.center,
        ),
      ),
      Expanded(
          child: Divider(
        color: Color(0xFFE5E5E5),
      )),
    ],
  );
}

Widget signInGoogleFacebookButton(Size size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      //sign in google button
      Container(
        alignment: Alignment.center,
        width: size.width / 3,
        height: size.height / 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.0,
            color: Colors.white,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon of google
            HTIcon(
              iconName: AssetConstants.icons.googleIcon,
              width: 28,
              height: 28,
            ),
            const SizedBox(
              width: 16,
            ),
            //google txt
            const Text(
              'Google',
              style: htDarkBlueNormalStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 16,
      ),

      //sign in facebook button
      Container(
        alignment: Alignment.center,
        width: size.width / 3,
        height: size.height / 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.0,
            color: Colors.white,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //facebook icon
            HTIcon(
              iconName: AssetConstants.icons.facebookIcon,
              width: 28,
              height: 28,
            ),
            const SizedBox(
              width: 16,
            ),
            //facebook txt
            const Text(
              'Facebook',
              textAlign: TextAlign.center,
              style: htDarkBlueNormalStyle,
            ),
          ],
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
          text: 'Already have account? ',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: 'Sign In',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              goTo(path: RoutePath.signIn);
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
