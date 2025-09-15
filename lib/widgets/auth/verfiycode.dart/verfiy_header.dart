import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerfiyHeader extends StatelessWidget {
  const VerfiyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
           
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                
                icon: const Icon(Icons.arrow_forward, color: AppColors.white),
                onPressed: () => Get.back(),
              ),
            ),
            const Spacer(),
            Text(
              'التحقق من الرمز',
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.white,
                fontSize: 34, // Adjusted font size
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'أدخل الرمز المكون من 6 أرقام الذي تم إرساله إلى هاتفك.',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.white.withOpacity(0.9),
              ),
            ),
             const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}
