
import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:abshr/controler/auth/verfiycode_controller.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerificationCard extends StatelessWidget {
  final VerifyCodeController controller;

  const VerificationCard({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 55,
      textStyle: AppTextStyles.headlineMedium
          .copyWith(fontSize: 22, color: AppColors.textPrimary),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'تم إرسال الرمز إلى بريدك الاكتروني:\n${controller.email}',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 6,
              controller: controller.pinController,
              focusNode: controller.focusNode,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: AppColors.primaryGreen, width: 2),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: AppColors.warning, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.verifyCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text('تحقق', style: AppTextStyles.buttonText),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'لم تستلم الرمز؟',
                style: AppTextStyles.bodySmall,
              ),
              TextButton(
                onPressed: controller.resendCode,
                child: Text(
                  'إعادة الإرسال',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
