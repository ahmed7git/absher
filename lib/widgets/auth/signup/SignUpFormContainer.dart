import 'package:abshr/controler/auth/auth_selection_controller.dart';
import 'package:abshr/controler/auth/signup_controller.dart';
import 'package:abshr/widgets/auth/Login/customtext.dart';
import 'package:abshr/widgets/auth/signup/phone_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupForm extends StatelessWidget {
  final SignupController controller;
  const SignupForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [

            CustomTextField(
              controller: controller.fullNameController,
              validator: controller.validateFullName,
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

            PhoneFormField(
              controller: controller.phoneController,
              validator: controller.validatePhone,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.passwordController,
              validator: controller.validatePassword,
              hintText: 'كلمة المرور',
              icon: Icons.lock_outline_rounded,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            // --- Confirm Password Field (Added for all users) ---
            CustomTextField(
              controller: controller.confirmPasswordController,
              validator: controller.validateConfirmPassword,
              hintText: 'تأكيد كلمة المرور',
              icon: Icons.lock_person_rounded,
              isPassword: true,
            ),
            const SizedBox(height: 16),

            Obx(() {
              if (controller.userRole.value == UserType.provider) {
                return Column(
                  children: [
                    CustomTextField(
                      controller: controller.serviceNameController,
                      validator: controller.validateServiceName,
                      hintText: 'الخدمة التي تقدمها',
                      icon: Icons.work_outline,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.regionController,
                      validator: controller.validateRegion,
                      hintText: 'المنطقة',
                      icon: Icons.map_outlined,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.locationController,
                      validator: controller.validateLocation,
                      hintText: 'حدد موقعك',
                      icon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              } else {
                return const SizedBox(height: 8);
              }
            }),


            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                    onPressed:
                        controller.isLoading.value ? null : controller.signUp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('إنشاء حساب'),
                  )),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

