import 'dart:ui';
import 'package:abshr/app_route.dart';
import 'package:abshr/constants/app_thems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserType { user, provider }

class AuthSelectionController extends GetxController
    with GetSingleTickerProviderStateMixin {
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

  void onContinuePressed() {
    if (selectedType.value == null) {
      showErrorSnackbar("الرجاء اختيار هويتك أولاً للمتابعة.");
    } else {
      String title = selectedType.value == UserType.provider
          ? 'تسجيل دخول مقدم خدمة'
          : 'تسجيل دخول مستخدم';
      Get.toNamed(AppRoutes.login, arguments: {
        'role': selectedType.value,
        'title': title,
      });
    }
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

