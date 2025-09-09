import 'package:abshr/constants/app_thems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedTopCircle extends StatelessWidget {
  final Animation<Offset> animation;
  const AnimatedTopCircle
  ({required this.animation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -Get.width * 0.3,
      right: -Get.width * 0.3,
      child: SlideTransition(
        position: animation, 
        child: Container(
          width: Get.width * 0.7,
          height: Get.width * 0.7,
          decoration: BoxDecoration(
            color: AppColors.accentOrange.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}