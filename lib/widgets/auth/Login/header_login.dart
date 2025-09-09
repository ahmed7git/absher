import 'package:abshr/app_route.dart';
import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                  onPressed: () => Get.toNamed(AppRoutes.signUp),
                  child: Text(
                    'إنشاء حساب',
                    style: AppTextStyles.bodyLarge.copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'تسجيل الدخول',
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
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