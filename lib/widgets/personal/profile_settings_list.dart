import 'package:abshr/controler/home/Profile_Controller.dart';
import 'package:abshr/widgets/personal/SettingsSwitchItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ProfileSettingsList extends StatelessWidget {
  final ProfileController controller;
  const ProfileSettingsList({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SettingsListItem(
              title: 'تغيير كلمة المرور',
              icon: Icons.lock_outline,
              onTap: () => controller.changePassword()),
          const Divider(indent: 20, endIndent: 20),
          SettingsListItem(
              title: 'سياسة الخصوصية',
              icon: Icons.privacy_tip_outlined,
              onTap: () {}),
          SettingsListItem(
              title: 'الشروط والأحكام',
              icon: Icons.description_outlined,
              onTap: () {}),
          SettingsListItem(
              title: ' فريق الدعم',
              icon: Icons.headset_mic_outlined,
              onTap: () {}),
          const Divider(indent: 20, endIndent: 20),
          Obx(() => SettingsSwitchItem(
                title: 'المظهر الداكن',
                icon: Icons.brightness_6_outlined,
                value: controller.isDarkMode.value,
                onChanged: (value) => controller.changeTheme(value),
              )),
          Obx(() => SettingsSwitchItem(
                title: 'القفل بالبصمة',
                icon: Icons.fingerprint,
                value: controller.isBiometricEnabled.value,
                onChanged: (value) => controller.toggleBiometrics(value),
              )),
          const Divider(indent: 20, endIndent: 20),
          SettingsListItem(
            title: 'تسجيل الخروج',
            icon: Icons.logout,
            onTap: () => controller.signOut(),
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}
