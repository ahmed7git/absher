import 'package:abshr/constants/app_thems.dart';
import 'package:flutter/material.dart';

class Headerbackground extends StatelessWidget {
  const Headerbackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
    );
  }
  }
