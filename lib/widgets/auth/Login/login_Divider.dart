import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('أو', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight)),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}