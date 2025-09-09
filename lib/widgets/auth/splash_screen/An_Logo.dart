import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';


class AnimatedLogoAndText extends StatelessWidget {
  final Animation<double> animation;
  const AnimatedLogoAndText({required this.animation, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGreen.withOpacity(0.4),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.local_shipping_outlined,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'أبشر',
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 48,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'خدمات النقل والشحن',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}