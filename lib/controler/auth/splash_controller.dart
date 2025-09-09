import 'package:abshr/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> topCircleAnimation;
  late Animation<Offset> bottomCircleAnimation;
  late Animation<double> logoAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this, 
    );

    topCircleAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    bottomCircleAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
         Get.offNamed(AppRoutes.selection);
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}