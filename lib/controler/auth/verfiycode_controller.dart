import 'package:abshr/app_route.dart';
import 'package:abshr/widgets/auth/signup/SignUpSuccessScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyCodeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;
  var isLoading = false.obs;
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  late String email;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments?['email'] ?? 'لم يتم توفير بريد إلكتروني';

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
    pinController.dispose();
    focusNode.dispose();
    animationController.dispose();
    super.onClose();
  }

  Future<void> verifyCode() async {
    if (pinController.text.length != 6) {
      Get.snackbar(
        'رمز غير مكتمل',
        'الرجاء إدخال الرمز المكون من 6 أرقام',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await supabase.auth.verifyOTP(
        type: OtpType.signup,
        email: email,
        token: pinController.text,
      );

      if (response.session != null && response.user != null) {
      
        Get.offAllNamed(AppRoutes.home);
        Get.snackbar('نجاح', 'تم التحقق من حسابك وتسجيل دخولك بنجاح.');

      } else {
         _showSuccessSheet();
      }
    } on AuthException catch (e) {
      Get.snackbar('خطأ في التحقق', e.message,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('خطأ غير متوقع', 'حدث خطأ ما، يرجى المحاولة مرة أخرى',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendCode() async {
    try {
      await supabase.auth.resend(type: OtpType.signup, email: email);
      Get.snackbar(
        'تم الإرسال',
        'تم إرسال رمز تحقق جديد إلى بريدك الإلكتروني بنجاح.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AuthException catch (e) {
      Get.snackbar('خطأ في الإرسال', e.message,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _showSuccessSheet() {
    Get.bottomSheet(
      const SignUpSuccessScreen(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
