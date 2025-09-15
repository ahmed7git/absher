import 'package:abshr/controler/auth/splash_controller.dart';
import 'package:abshr/widgets/auth/splash_screen/An_Bottom_circle.dart';
import 'package:abshr/widgets/auth/splash_screen/An_Logo.dart';
import 'package:abshr/widgets/auth/splash_screen/An_Top_cricle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          AnimatedTopCircle(animation: controller.topCircleAnimation),
          AnimatedBottomCircle(animation: controller.bottomCircleAnimation),
          AnimatedLogoAndText(animation: controller.logoAnimation),
        ],
      ),
    );
  }
}