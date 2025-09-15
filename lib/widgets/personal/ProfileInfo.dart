import 'package:abshr/controler/home/Profile_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInfo extends StatelessWidget {
  final ProfileController controller;
  const ProfileInfo({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 46,
            backgroundImage: NetworkImage(
              'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg',
            ),
          ),
        ),
        const SizedBox(height: 16),
        Obx(() => Text(
              controller.userName.value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
            )),
        const SizedBox(height: 4),
        Obx(() => Text(
              controller.userEmail.value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16),
            )),
      ],
    );
  }
}
