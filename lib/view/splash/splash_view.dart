import 'package:flutter/material.dart';
import 'package:health_tourism/product/navigation/router.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();

}


class _SplashViewState extends State<SplashView> {
  // implement dispose and initState

  @override
  Widget build(BuildContext context) {
    goToWithWait(path: RoutePath.root);
    return const Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}
