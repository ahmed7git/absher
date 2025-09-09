import 'dart:ui';
import 'package:abshr/app_route.dart';
import 'package:abshr/constants/app_thems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserType { user, provider }

class AuthSelectionController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation; 
  late Animation<Offset> slideAnimation; 

  final selectedType = Rxn<UserType>();

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );


    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCubic,
    ));


    Future.delayed(const Duration(milliseconds: 300), () {
      
      if (!isClosed) {
        animationController.forward();
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void selectUserType(UserType type) {
    selectedType.value = type;
  }

  void navigateToLogin() {
    Get.toNamed(AppRoutes.login);
  }

  void onContinuePressed() {
    if (selectedType.value == null) {
      showErrorSnackbar("الرجاء اختيار هويتك أولاً للمتابعة.");
    } else if (selectedType.value == UserType.provider) {
      showComingSoonSnackbar();
    } else if (selectedType.value == UserType.user) {
      Get.toNamed(AppRoutes.login);
    }
  }

  void showComingSoonSnackbar() {
    Get.snackbar(
      "قريباً!",
      "خيار تسجيل مقدمي الخدمة قيد التطوير حالياً.",
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.warning.withOpacity(0.9),
      colorText: AppColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
      icon: const Icon(Icons.info_outline, color: Colors.white, size: 28),
      duration: const Duration(seconds: 4),
    );
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      "تنبيه",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.warning.withOpacity(0.9),
      colorText: AppColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
    );
  }
}

