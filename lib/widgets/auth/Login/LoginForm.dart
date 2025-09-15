import 'package:abshr/controler/auth/login_controlls.dart';
import 'package:abshr/widgets/auth/Login/customtext.dart';
import 'package:abshr/widgets/auth/Login/login_ActionButtons.dart';
import 'package:abshr/widgets/auth/Login/login_Divider.dart';
import 'package:abshr/widgets/auth/Login/login_SocialLoginButtons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loginform extends StatelessWidget {
  final LoginController controller;
  const Loginform({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.emailController,
              validator: controller.validateEmail,
              hintText: 'البريد الإلكتروني',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.passwordController,
              validator: controller.validatePassword,
              hintText: 'كلمة المرور',
              icon: Icons.lock_outline_rounded,
              isPassword: true,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: controller.navigateToForgotPassword,
                child: const Text('هل نسيت كلمة المرور؟'),
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => LoginActionButtons(
                  onLogin: controller.login,
                  onBiometricLogin: controller.signInWithBiometrics,
                  isLoading: controller.isLoading.value,
                )),
            const SizedBox(height: 24),
            const LoginDivider(),
            const SizedBox(height: 24),
            LoginSocialloginbuttons(onPressed: controller.signInWithGoogle),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
