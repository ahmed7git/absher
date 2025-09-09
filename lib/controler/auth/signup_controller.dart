import 'package:abshr/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpController extends GetxController
    with GetSingleTickerProviderStateMixin {

  final supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();


  var isLoading = false.obs;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneController;
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController();

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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    animationController.dispose();
    super.onClose();
  }


  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال الاسم الكامل';
    }
    return null;
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
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء تأكيد كلمة المرور';
    }
    if (value != passwordController.text) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال رقم الهاتف';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'الرجاء إدخال رقم هاتف صحيح';
    }
    return null;
  }


  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    isLoading.value = true;
    try {

      await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {
          'full_name': nameController.text,
          'phone': phoneController.text,
        },
      );

      Get.toNamed(
        AppRoutes.verifyCode,
        arguments: {'email': emailController.text},
      );

    } on AuthException catch (e) {
      Get.snackbar(
        'خطأ في إنشاء الحساب',
        e.message,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ غير متوقع',
        'حدث خطأ ما، يرجى المحاولة مرة أخرى.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

