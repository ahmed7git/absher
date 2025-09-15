import 'package:abshr/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyPasswordResetController extends GetxController {
  final supabase = Supabase.instance.client;
  var isLoading = false.obs;

  final pinController = TextEditingController();
  final focusNode = FocusNode();

  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments?['email'] ?? 'No email provided';
  }

  @override
  void onClose() {
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> verifyOtp() async {
    if (pinController.text.length != 6) {
      Get.snackbar('خطأ', 'رمز التحقق يجب أن يكون 6 أرقام.');
      return;
    }

    isLoading.value = true;
    try {
      final response = await supabase.auth.verifyOTP(
        type: OtpType.recovery,
        token: pinController.text.trim(),
        email: email,
      );

      if (response.user != null) {
        
        Get.toNamed(AppRoutes.updatePassword);
      } else {
        throw const AuthException('رمز التحقق غير صالح أو منتهي الصلاحية.');
      }
    } on AuthException catch (e) {
      Get.snackbar('خطأ في التحقق', e.message);
    } catch (e) {
      Get.snackbar('خطأ غير متوقع', 'حدث خطأ ما، يرجى المحاولة مرة أخرى.');
    } finally {
      isLoading.value = false;
    }
  }
}

