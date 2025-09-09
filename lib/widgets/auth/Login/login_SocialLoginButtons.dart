import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';

class LoginSocialloginbuttons extends StatelessWidget {
  const LoginSocialloginbuttons({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {}, // Logic for Google Sign-In
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: Colors.grey.shade300),
        backgroundColor: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
            height: 24,
            width: 24,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.login, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 16),
          Text(
            'المتابعة عبر جوجل',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

