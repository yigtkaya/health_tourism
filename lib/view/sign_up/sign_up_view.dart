import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/components/ht_text_field.dart';
import '../../core/constants/horizontal_space.dart';
import '../../core/constants/theme/color/gradient_colors.dart';
import '../../core/constants/theme/styles.dart';
import '../../core/constants/theme/theme_manager.dart';
import '../../core/constants/vertical_space.dart';
import '../../core/ht_text.dart';
import '../login/LoginView.dart';


class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();


    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorConstants
                    .colorPlateList[7 % (ColorConstants.colorPlateList.length)]
                    .startColor,
                ColorConstants
                    .colorPlateList[7 % (ColorConstants.colorPlateList.length)]
                    .endColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.2],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: addressFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Align(
                      alignment: Alignment.center,
                      child: HTText(
                        label: "Sign Up",
                        style: null,
                        color: Colors.white,
                      )),
                  const VerticalSpace(
                    spaceAmount: 20,
                  ),
                  const HTText(label: "Email", style: KTLabelStyle),
                  HTTextField(
                    textController: emailController,
                    title: "Email",
                  ),
                  const HTText(
                      label: "error",
                      style: null,
                      color: Colors.red),
                  const VerticalSpace(
                    spaceAmount: 30,
                  ),
                  const HTText(label: "Password", style: KTLabelStyle),
                  HTTextField(
                    textController: passwordController,
                    title: "Password",
                  ),
                  const HTText(
                      label: "error",
                      style: null,
                      color: Colors.red),
                  const VerticalSpace(
                    spaceAmount: 20,
                  ),
                  const HTText(label: "Confirm Password", style: KTLabelStyle),
                  HTTextField(
                    textController: confirmPasswordController,
                    title: "Confirm Password",
                  ),
                  HTText(
                      label: "pwErrer",
                      style: null,
                      color: Colors.red),
                  const VerticalSpace(
                    spaceAmount: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF4989D7),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                        onPressed: () {
                        },
                        child: HTText(
                          label: "SIGN UP",
                          color: Colors.blue,
                          style: null,
                        )),
                  ),
                  const VerticalSpace(
                    spaceAmount: 50,
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: HTText(label: "OR", style: KTLabelStyle)),
                  const VerticalSpace(
                    spaceAmount: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF4989D7),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                        onPressed: () {
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 35.0,
                              width: 30.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/google.png'),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const HorizontalSpace(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: HTText(
                                label: "Sign in with Google",
                                color: ThemeManager.instance?.getCurrentTheme
                                    .colorTheme.colors.abbey,
                                style: KTLabelStyle,
                              ),
                            )
                          ],
                        )),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LoginView())
                          )
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Already have account? ',
                                  style: KTLabelStyle),
                              TextSpan(text: 'Sign In', style: KTLabelStyle),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

}
