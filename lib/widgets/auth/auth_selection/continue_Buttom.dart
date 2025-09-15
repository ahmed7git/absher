import 'package:abshr/constants/app_thems.dart';
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
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.primaryGreen,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
    
        child: Text(
          "متابعة",
   
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primaryGreen,
              ),
        ),
      ),
    );
  }
}
