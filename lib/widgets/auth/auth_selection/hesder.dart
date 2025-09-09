import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 70, 32, 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_shipping_outlined,
              color: AppColors.primaryGreen,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text("أهلاً بك في أبشر", style: AppTextStyles.headlineLarge),
          const SizedBox(height: 8),
          Text(
            "اختر هويتك للبدء في رحلتك معنا",
            style: AppTextStyles.bodySmall.copyWith(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}