import 'package:abshr/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {

  final supabase = Supabase.instance.client;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutQuint,
    ));

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );


    Future.delayed(const Duration(milliseconds: 300), () {
      if (!isClosed) {
        animationController.forward();
      }
    });
  }

  @override
  void onClose() {

    emailController.dispose();
    passwordController.dispose();
    animationController.dispose();
    super.onClose();
  }


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }
    if (!GetUtils.isEmail(value)) {
      return 'الرجاء إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    return null;
  }

  // --- دالة تسجيل الدخول ---
  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    isLoading.value = true;
    try {
    
      await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

     
      Get.offAllNamed(AppRoutes.home);
    } on AuthException catch (e) {
      Get.snackbar(
        'خطأ في تسجيل الدخول',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ غير متوقع',
        'حدث خطأ ما، يرجى المحاولة مرة أخرى.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

