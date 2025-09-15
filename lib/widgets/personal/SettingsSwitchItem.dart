
import 'package:abshr/constants/app_thems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsListItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : (Get.isDarkMode ? Colors.white70 : AppColors.textSecondary);
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: isDestructive ? AppColors.error : null)),
      trailing: isDestructive ? null : Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
      onTap: onTap,
    );
  }
}

class SettingsSwitchItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchItem({
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(icon, color: Get.isDarkMode ? Colors.white70 : AppColors.textSecondary),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primaryGreen,
    );
  }
}