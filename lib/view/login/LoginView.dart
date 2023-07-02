import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/theme/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF21899C),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: <Widget>[
              //left side background design. I use a svg image here
              Positioned(
                left: -34,
                top: 181.0,
                child: SvgPicture.string(
                  // Group 3178
                  '<svg viewBox="-34.0 181.0 99.0 99.0" ><path transform="translate(-34.0, 181.0)" d="M 74.25 0 L 99 49.5 L 74.25 99 L 24.74999618530273 99 L 0 49.49999618530273 L 24.7500057220459 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-26.57, 206.25)" d="M 0 0 L 42.07500076293945 16.82999992370605 L 84.15000152587891 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(15.5, 223.07)" d="M 0 56.42999649047852 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 99.0,
                  height: 99.0,
                ),
              ),

              //right side background design. I use a svg image here
              Positioned(
                right: -52,
                top: 45.0,
                child: SvgPicture.string(
                  // Group 3177
                  '<svg viewBox="288.0 45.0 139.0 139.0" ><path transform="translate(288.0, 45.0)" d="M 104.25 0 L 139 69.5 L 104.25 139 L 34.74999618530273 139 L 0 69.5 L 34.75000762939453 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(298.42, 80.45)" d="M 0 0 L 59.07500076293945 23.63000106811523 L 118.1500015258789 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(357.5, 104.07)" d="M 0 79.22999572753906 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 139.0,
                  height: 139.0,
                ),
              ),

              //content ui
              Positioned(
                top: 8.0,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //logo section
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              logo(size.height / 8, size.height / 8),
                              const SizedBox(
                                height: 16,
                              ),
                              richText(23.12),
                            ],
                          ),
                        ),

                        //continue with email for sign in app text
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Continue with email for sign in App',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        //email and password TextField here
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              emailTextField(size),
                              const SizedBox(
                                height: 8,
                              ),
                              passwordTextField(size),
                              const SizedBox(
                                height: 16,
                              ),
                              buildRemember(size),
                            ],
                          ),
                        ),

                        //sign in button & continue with text here
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              signInButton(size),
                              const SizedBox(
                                height: 16,
                              ),
                              buildContinueText(),
                            ],
                          ),
                        ),

                        //footer section. google, facebook button and sign up text here
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              signInGoogleFacebookButton(size),
                              const SizedBox(
                                height: 16,
                              ),
                              buildFooter(size),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return SvgPicture.asset(
      'assets/logo2.svg',
      height: height_,
      width: width_,
    );
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: 23.12,
          color: Colors.white,
          letterSpacing: 1.999999953855673,
        ),
        children: const [
          TextSpan(
            text: 'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'PAGE',
            style: TextStyle(
              color: Color(0xFFFE9879),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF4DA1B0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //mail icon
            const Icon(
              Icons.mail_rounded,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //email address textField
            Expanded(
              child: TextField(
                maxLines: 1,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    hintText: 'Enter your gmail address',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF4DA1B0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //lock logo here
            const Icon(
              Icons.lock,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //password textField
            Expanded(
              child: TextField(
                maxLines: 1,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: const Icon(
                      Icons.visibility,
                      color: Colors.white70,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRemember(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 17.0,
          height: 17.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            gradient: const LinearGradient(
              begin: Alignment(5.65, -1.0),
              end: Alignment(-1.0, 1.94),
              colors: [Color(0xFF00AD8F), Color(0xFF7BF4DF)],
            ),
          ),
          child: SvgPicture.string(
            // Vector 5
            '<svg viewBox="47.0 470.0 7.0 4.0" ><path transform="translate(47.0, 470.0)" d="M 0 1.5 L 2.692307710647583 4 L 7 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" /></svg>',
            width: 7.0,
            height: 4.0,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          'Remember me',
          style: htLabelStyle,
        ),
      ],
    );
  }

  Widget signInButton(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFFF56B3F),
      ),
      child: Text(
        'Sign in',
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildContinueText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Expanded(
            child: Divider(
              color: Colors.white,
            )),
        Expanded(
          child: Text(
            'Or Continue with',
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Expanded(
            child: Divider(
              color: Colors.white,
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
          width: size.width / 2.8,
          height: size.height / 13,
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
              HTIcon(iconName: AssetConstants.icons.googleIcon, width: 28, height: 28,),
              const SizedBox(
                width: 16,
              ),
              //google txt
              Text(
                'Google',
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
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
          width: size.width / 2.8,
          height: size.height / 13,
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
              HTIcon(iconName: AssetConstants.icons.facebookIcon,),
              const SizedBox(
                width: 16,
              ),

              //facebook txt
              Text(
                'Facebook',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFooter(Size size) {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.nunito(
            fontSize: 16.0,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'Don’t have account? ',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: 'Sign up',
              style: GoogleFonts.nunito(
                color: const Color(0xFFF9CA58),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}