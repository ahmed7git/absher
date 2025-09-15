
import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/controler/auth/auth_selection_controller.dart';
import 'package:abshr/widgets/auth/auth_selection/continue_Buttom.dart';
import 'package:abshr/widgets/auth/auth_selection/hesder.dart';
import 'package:abshr/widgets/auth/auth_selection/selection_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthSelectionScreen extends GetView<AuthSelectionController> {
  const AuthSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: FadeTransition(
              opacity: controller.fadeAnimation,
              child: const Header(),
            ),
          ),
          Expanded(
            flex: 6,
            child: SlideTransition(
              position: controller.slideAnimation,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen, 
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Obx(() {
                        return SelectionCard(
                          icon: Icons.person_search_outlined,
                          title: "أنا أبحث عن خدمة",
                          subtitle: "اطلب خدمات النقل والشحن بكل سهولة",
                          isSelected: controller.selectedType.value == UserType.user,
                          onTap: () => controller.selectUserType(UserType.user),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return SelectionCard(
                          icon: Icons.work_outline_rounded,
                          title: "أنا أقدم خدمة",
                          subtitle: "انضم كشريك وابدأ في استقبال الطلبات",
                          isSelected: controller.selectedType.value == UserType.provider,
                          onTap: () => controller.selectUserType(UserType.provider),
                        );
                      }),
                      const Spacer(),
                      ContinueButton(onPressed: controller.onContinuePressed),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
