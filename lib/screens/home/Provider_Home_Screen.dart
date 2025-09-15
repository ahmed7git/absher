import 'package:abshr/app_route.dart';
import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/controler/home/provider_home_controller.dart';
import 'package:abshr/widgets/home/Requests_View_Widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderHomeScreen extends GetView<ProviderHomeController> {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلبات الجديدة'),
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'الملف الشخصي',
            onPressed: () {
              Get.toNamed(AppRoutes.profilescreen);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'تسجيل الخروج',
            onPressed: () => controller.signOut(),
          ),
        ],
      ),
      body: const RequestsView(), 
    );
  }
}
