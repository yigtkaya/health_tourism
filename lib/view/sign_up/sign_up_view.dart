import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/textfields/ht_password_field.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/components/textfields/ht_email_field.dart';
import 'package:health_tourism/core/components/textfields/customTextField.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/auth/auth_cubit.dart';
import '../../core/constants/horizontal_space.dart';
import '../../product/navigation/route_paths.dart';
import '../../product/navigation/router.dart';
import '../../core/components/ht_icon.dart';
import '../../core/constants/asset.dart';
import '../../product/theme/styles.dart';
import '../../product/theme/theme_manager.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
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
    nameController.dispose();
    confirmPassController.dispose();
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

  bool hasMatchedPassword(String password, String confPassword) {
    return password == confPassword;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HTText(
                    label: "Sign Up",
                    style: htTitleStyle2,
                  ),
                  const VerticalSpace(
                    spaceAmount: 50,
                  ),
                  HTCustomTextField(textController: nameController),
                  const VerticalSpace(),
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
                        hasMatchedPassword(value, confPassword);
                      },
                      textController: passController,
                      ),
                  const VerticalSpace(),
                  HTPasswordField(
                      onChanged: (value) {
                        updateConfPassword(value);
                        hasMatchedPassword(password, value);
                      },
                      textController: confirmPassController,
                      ),
                  hasMatchedPassword(password, confPassword)
                      ? const SizedBox.shrink()
                      : Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 2),
                        child: HTText(label: "Passwords are not same with each other", style: htSmallRedLabelStyle),
                      ),
                  const VerticalSpace(spaceAmount: 40),
                  GestureDetector(
                    onTap: () {
                      if (!hasMatchedPassword(password, confPassword)) {
                        showToastMessage("Passwords are not same with each other");
                        return;
                      }
                      try {
                        context
                            .read<AuthCubit>()
                            .signUpWithEmailAndPassword(email, password);

                        confirmPassController.clear();
                        passController.clear();
                        emailController.clear();
                        nameController.clear();

                      } on Exception catch (e) {
                        print(e.toString());
                      }
                    },
                    child: signUpButton(size),
                  ),
                  const VerticalSpace(spaceAmount: 30),
                  buildFooter(),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HTText(
                    label: "Sign up with social networks:",
                    style: htBlueLabelStyle,
                  ),
                  const VerticalSpace(
                    spaceAmount: 20,
                  ),
                  signInAlternatives(size, authCubit),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

Widget signUpButton(Size size) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: const Color(0xFF58A2EB),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: HTText(
        label: "Sign up",
        style: htBoldLabelStyle,
      ),
    ),
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
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: HTIcon(
                iconName: AssetConstants.icons.googleIconPlus,
                width: 24,
                height: 24,
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
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: HTIcon(
                iconName: AssetConstants.icons.facebookIconSimple,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

void showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget buildFooter() {
  return Text.rich(
    TextSpan(
      style: htDarkBlueNormalStyle,
      children: [
        TextSpan(
          text: 'Already have an account? ',
          style: GoogleFonts.nunitoSans(
            fontSize: 14.0,
            color: ThemeManager
                .instance?.getCurrentTheme.colorTheme.openBlueTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextSpan(
          text: 'Sign in',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              goTo(path: RoutePath.signIn);
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
