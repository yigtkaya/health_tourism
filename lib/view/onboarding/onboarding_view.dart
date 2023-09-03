import 'package:flutter/material.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'package:health_tourism/product/theme/styles.dart';
import 'package:health_tourism/product/theme/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../product/navigation/route_paths.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController pageController;
  int currentIndex = 0;
  late bool seen;

  List pages = [
    const OnboardingContentWithLogo(
        title: "VoyEsthetic",
        subTitle: "Hygiene, Comfort, and Quality All Together!",
        image: "assets/images/logo.png"),
    const OnboardingContent(
        title: "Find your Clinic and Make an Appointment With Ease!",
        subTitle: "Natural and distinctive results in hair transplantation",
        image: "assets/images/onboarding_img1.png"),
    const OnboardingContent(
        title: "Enjoy the Historical Streets of Turkey",
        subTitle:
            "Feel comfortable traveling and transplanting with VoyEsthetic",
        image: "assets/images/onboarding_img2.png"),
  ];
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  _storeOnboardingInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoard', true);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: pages.length,
              controller: pageController,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),
          GestureDetector(
            onTap: currentIndex == 2
                ? () {
                    _storeOnboardingInfo();
                    goTo(path: RoutePath.signIn);
                  }
                : () => pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn),
            child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF58A2EB),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                height: size.height * 0.06,
                child: Center(
                  child: HTText(
                      label: currentIndex == 2 ? 'Get Started' : 'Next',
                      style: htBoldLabelStyle),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  pages.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: PageIndicator(
                      isActive: index == currentIndex,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}

class OnboardingContent extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  const OnboardingContent(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(title, style: htTitleStyle, textAlign: TextAlign.center),
            const VerticalSpace(
              spaceAmount: 40,
            ),
            SizedBox(
                height: size.height * 0.4,
                width: size.width * 0.8,
                child: Image.asset(image)),
            const Spacer(),
            Text(subTitle,
                style: htOnboardingSubTitle, textAlign: TextAlign.center),
            const VerticalSpace(
              spaceAmount: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingContentWithLogo extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  const OnboardingContentWithLogo(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            height: size.height * 0.2,
            width: size.width * 0.5,
            child: Image.asset(image),
          ),
          const Spacer(),
          Text(title, style: htTitleStyle, textAlign: TextAlign.center),
          const VerticalSpace(
            spaceAmount: 40,
          ),
          Text(subTitle,
              style: htOnboardingSubTitle, textAlign: TextAlign.center),
          const Spacer(),
        ],
      ),
    );
  }
}

class PageIndicator extends StatefulWidget {
  final bool isActive;
  const PageIndicator({super.key, this.isActive = false});

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 20,
      decoration: BoxDecoration(
        color: widget.isActive
            ? ThemeManager
                .instance?.getCurrentTheme.colorTheme.darkBlueTextColor
            : const Color(0xFFD3E3F1),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
