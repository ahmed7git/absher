
import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/controler/auth/login_controlls.dart';
import 'package:abshr/widgets/auth/Login/header_login.dart';
import 'package:abshr/widgets/auth/Login/loginform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: FadeTransition(
                        opacity: controller.fadeAnimation,
                        child:const HeaderLogin(),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: SlideTransition(
                        position: controller.slideAnimation,
                        child:Loginform(controller: controller),
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

