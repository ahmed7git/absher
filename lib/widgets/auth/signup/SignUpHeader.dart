
import 'package:abshr/app_route.dart' show AppRoutes;
import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({Key? key}) : super(key: key);

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
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.white),
                  onPressed: () => Get.back(),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  child: Text('تسجيل الدخول', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.white)),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'إنشاء حساب',
              style: AppTextStyles.headlineLarge.copyWith(color: AppColors.white, fontSize: 36),
            ),
            const SizedBox(height: 8),
            Text(
              'أهلاً بك! يرجى ملء بياناتك للانضمام إلينا.',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.white.withOpacity(0.9)),
            ),
          ],
        ),
      ),
    );
  }
}