
import 'dart:async';
import 'package:abshr/app_route.dart';
import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpSuccessScreen extends StatefulWidget {
  const SignUpSuccessScreen({Key? key}) : super(key: key);

  @override
  SignUpSuccessScreenState createState() => SignUpSuccessScreenState();
}

class SignUpSuccessScreenState extends State<SignUpSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Get.offAllNamed(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: AppColors.success, size: 50),
          ),
          const SizedBox(height: 24),
          Text('نجاح!', style: AppTextStyles.headlineLarge.copyWith(fontSize: 28)),
          const SizedBox(height: 8),
          Text(
            'تم إنشاء حسابك بنجاح.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),

          Text(
            'سيتم نقلك إلى الصفحة الرئيسية خلال لحظات...',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight),
          ),

          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

