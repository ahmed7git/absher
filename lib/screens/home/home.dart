import 'package:abshr/controler/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'تسجيل الخروج',
            onPressed: () {

              controller.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'أهلاً بك في الصفحة الرئيسية!',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
