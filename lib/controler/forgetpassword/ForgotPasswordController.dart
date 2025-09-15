import 'package:abshr/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordController extends GetxController {
  final supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty || !GetUtils.isEmail(value)) {
      return 'الرجاء إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  Future<void> sendResetLink() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;
    try {
      await supabase.auth.resetPasswordForEmail(
        emailController.text.trim(),
      );

    
      Get.toNamed(AppRoutes.verifyPasswordReset,
          arguments: {'email': emailController.text.trim()});

      Get.snackbar(
        'تم الإرسال',
        'تم إرسال رمز التحقق إلى بريدك الإلكتروني.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AuthException catch (e) {
      Get.snackbar('خطأ', e.message);
    } catch (e) {
      Get.snackbar('خطأ غير متوقع', 'حدث خطأ ما، يرجى المحاولة مرة أخرى.');
    } finally {
      isLoading.value = false;
    }
  }
}

