import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';


class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ContinueButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.primaryGreen,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.buttonText.copyWith(color: AppColors.primaryGreen),
        ),
        child: const Text("متابعة"),
      ),
    );
  }
}