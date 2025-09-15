import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:abshr/controler/auth/login_controlls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderLogin extends GetView<LoginController> {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 1, bottom: 10),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () => controller.navigateToSignUp(),
                  child: Text(
                    'إنشاء حساب',
                    style:
                        AppTextStyles.bodyLarge.copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Obx(() => Text(
                  controller.screenTitle.value,
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 8),
            Text(
              'مرحباً بعودتك! يرجى إدخال بياناتك للمتابعة.',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

