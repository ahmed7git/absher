import 'package:abshr/controler/home/Profile_Controller.dart';
import 'package:abshr/widgets/personal/HeaderBackground.dart';
import 'package:abshr/widgets/personal/ProfileInfo.dart';
import 'package:abshr/widgets/personal/profile_settings_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          const Headerbackground(),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: controller.profileInfoAnimation,
                  child: ProfileInfo(controller: controller),
                ),
                const SizedBox(height: 70),
                FadeTransition(
                  opacity: controller.settingsAnimation,
                  child: ProfileSettingsList(controller: controller),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}