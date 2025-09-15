import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';

class LoginActionButtons extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onBiometricLogin; 
  final bool isLoading;

  const LoginActionButtons({
    super.key,
    required this.onLogin,
    required this.onBiometricLogin, 
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: isLoading ? null : onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Text('تسجيل الدخول', style: AppTextStyles.buttonText),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: onBiometricLogin, // <-- تعديل هنا
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
