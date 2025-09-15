import 'package:abshr/constants/app_thems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedBottomCircle extends StatelessWidget {
  final Animation<Offset> animation;
  const AnimatedBottomCircle({required this.animation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -Get.width * 0.3,
      left: -Get.width * 0.3,
      child: SlideTransition(
        position: animation,
        child: Container(
          width: Get.width * 0.7,
          height: Get.width * 0.7,
          decoration: BoxDecoration(
            color: AppColors.primaryGreen.withOpacity(0.9), 
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}