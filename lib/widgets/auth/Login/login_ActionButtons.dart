import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';

class LoginActionbuttons extends StatelessWidget {
    final VoidCallback onLogin;
  const LoginActionbuttons({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text('تسجيل الدخول', style: AppTextStyles.buttonText),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.lightGray),
              ),
            ),
            child: const Icon(
              Icons.fingerprint,
              color: AppColors.primaryGreen,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}