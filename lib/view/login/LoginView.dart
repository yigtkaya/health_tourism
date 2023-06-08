import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tourism/view/sign_up/sign_up_view.dart';

import '../../core/components/ht_text_field.dart';
import '../../core/constants/gradient_colors.dart';
import '../../core/constants/horizontal_space.dart';
import '../../core/constants/theme/theme_manager.dart';
import '../../core/constants/vertical_space.dart';
import '../../core/ht_text.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key){}


  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

    // TODO: implement build
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
                          .colorPlateList[
                      7 % (ColorConstants.colorPlateList.length)]
                          .startColor,
                      ColorConstants
                          .colorPlateList[
                      7 % (ColorConstants.colorPlateList.length)]
                          .endColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 1.2],
                    tileMode: TileMode.clamp),
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
                      const Align(
                          alignment: Alignment.center,
                          child: HTText(
                            label: "Sign In",
                            style: null,
                            color: Colors.white,
                          )),
                      const VerticalSpace(
                        spaceAmount: 20,
                      ),
                      const HTText(label: "Email", style: null),
                      HTTextField(
                        textController: emailController,
                        title: "Email",
                      ),
                      const HTText(
                          label: "error",
                          style: null,
                          color: Colors.red),
                      const VerticalSpace(
                        spaceAmount: 20,
                      ),
                      const HTText(label: "Password", style: null),
                      HTTextField(
                        textController: passwordController,
                        title: "Password",
                      ),
                      const HTText(
                          label: "",
                          style: null,
                          color: Colors.red),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xff364d64),
                          ),
                          onPressed: () {},
                          child:
                          const Text('Forgot Password ?', style: null),
                        ),
                      ),
                      const VerticalSpace(),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xff364d64),
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              onPressed: () {},
                              child: const HTText(
                                label: "LOGIN",
                                color: Colors.black,
                                style: null,
                              )),
                        ),
                      ),
                      const VerticalSpace(
                        spaceAmount: 50,
                      ),
                      const Align(
                          alignment: Alignment.center,
                          child: HTText(label: "OR", style: null)),
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
                              mainAxisSize: MainAxisSize.min,
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
                                        .colorTheme.colors.abbey, style: null,
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
                                MaterialPageRoute(builder: (context) => const SignUpView())
                              )
                            },
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Don\'t have an Account? ',),
                                  TextSpan(text: 'Sign Up'),
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
