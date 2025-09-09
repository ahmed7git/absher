
import 'package:abshr/constants/app_thems.dart';
import 'package:abshr/constants/text_styles.dart';
import 'package:abshr/controler/auth/signup_controller.dart';
import 'package:abshr/widgets/auth/Login/customtext.dart';
import 'package:flutter/material.dart';

class SignUpFormContainer extends StatelessWidget {
  final SignUpController controller;
  const SignUpFormContainer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: controller.nameController,
              validator: controller.validateName,
              hintText: 'الاسم الكامل',
              icon: Icons.person_outline,
            ),
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
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.confirmPasswordController,
              validator: controller.validateConfirmPassword,
              hintText: 'تأكيد كلمة المرور',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.phoneController,
              validator: controller.validatePhone,
              hintText: 'رقم الهاتف',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text('إنشاء حساب', style: AppTextStyles.buttonText),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
