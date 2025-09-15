import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/controler/auth/verfiycode_controller.dart';
import 'package:abshr/widgets/auth/verfiycode.dart/VerificationCard.dart';
import 'package:abshr/widgets/auth/verfiycode.dart/verfiy_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyCodeScreen extends GetView<VerifyCodeController> {
  const VerifyCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen, 
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: FadeTransition(
                        opacity: controller.fadeAnimation,
                        child: const VerfiyHeader(),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: SlideTransition(
                        position: controller.slideAnimation,
                        child: VerificationCard(controller: controller),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
