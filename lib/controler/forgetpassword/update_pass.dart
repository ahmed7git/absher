import 'package:abshr/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatePasswordController extends GetxController {
  final supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _fromProfile = false;
  final screenTitle = 'تعيين كلمة المرور الجديدة'.obs;
  final screenSubtitle = 'لقد تم التحقق بنجاح. يرجى إدخال كلمة المرور الجديدة.'.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['fromProfile'] == true) {
      _fromProfile = true;
      screenTitle.value = 'تغيير كلمة المرور';
      screenSubtitle.value = 'أدخل كلمة المرور الجديدة لتأمين حسابك.';
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }

  Future<void> updatePassword() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      await supabase.auth.updateUser(
        UserAttributes(password: passwordController.text.trim()),
      );

      if (_fromProfile) {
        Get.back();
        Get.snackbar(
          'نجاح',
          'تم تحديث كلمة المرور بنجاح.',
        );
      } else {
        await supabase.auth.signOut();
        Get.offAllNamed(AppRoutes.selection);
        Get.snackbar(
          'نجاح',
          'تم تحديث كلمة المرور بنجاح. يمكنك الآن تسجيل الدخول.',
        );
      }
    } on AuthException catch (e) {
      Get.snackbar('خطأ', e.message);
    } catch (e) {
      Get.snackbar('خطأ غير متوقع', 'حدث خطأ ما، يرجى المحاولة مرة أخرى.');
    } finally {
      isLoading.value = false;
    }
  }
}
