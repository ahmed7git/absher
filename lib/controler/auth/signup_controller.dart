import 'package:abshr/controler/auth/auth_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:abshr/app_route.dart';

class SignupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController serviceNameController;
  late TextEditingController regionController;
  late TextEditingController locationController;

  final Rx<UserType> userRole = UserType.user.obs;
  final Rx<String> screenTitle = 'إنشاء حساب'.obs;

  @override
  void onInit() {
    super.onInit();
   
    if (Get.arguments != null && Get.arguments is Map) {
      final roleString = Get.arguments['role'];
       if (roleString == UserType.provider.toString()) {
        userRole.value = UserType.provider;
      } else {
        userRole.value = UserType.user;
      }
    }

    if (userRole.value == UserType.provider) {
      screenTitle.value = 'إنشاء حساب مقدم خدمة';
    } else {
      screenTitle.value = 'إنشاء حساب جديد';
    }
    
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    animationController.forward();
    
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    serviceNameController = TextEditingController();
    regionController = TextEditingController();
    locationController = TextEditingController();
  }

  @override
  void onClose() {
    animationController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    serviceNameController.dispose();
    regionController.dispose();
    locationController.dispose();
    super.onClose();
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال الاسم الكامل';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال البريد الإلكتروني';
    if (!GetUtils.isEmail(value)) return 'صيغة البريد الإلكتروني غير صحيحة';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال رقم الهاتف';
    if (!value.startsWith('7')) return 'يجب أن يبدأ الرقم بالرقم 7';
    if (value.length != 9) return 'يجب أن يتكون الرقم من 9 أرقام';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال كلمة المرور';
    if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء تأكيد كلمة المرور';
    if (value != passwordController.text) return 'كلمتا المرور غير متطابقتين';
    return null;
  }

  String? validateServiceName(String? value) {
    if (userRole.value == UserType.provider && (value == null || value.isEmpty)) {
      return 'الرجاء تحديد نوع الخدمة';
    }
    return null;
  }

  String? validateRegion(String? value) {
    if (userRole.value == UserType.provider && (value == null || value.isEmpty)) {
      return 'الرجاء تحديد المنطقة';
    }
    return null;
  }

  String? validateLocation(String? value) {
    if (userRole.value == UserType.provider && (value == null || value.isEmpty)) {
      return 'الرجاء تحديد موقعك';
    }
    return null;
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;
    
    isLoading.value = true;
    try {
 
      final Map<String, dynamic> userMetadata = {
        'full_name': fullNameController.text.trim(),
        'phone': '+967${phoneController.text.trim()}',
        'role': userRole.value.toString().split('.').last, 
      };

    
      if (userRole.value == UserType.provider) {
        userMetadata['service_name'] = serviceNameController.text.trim();
        userMetadata['region'] = regionController.text.trim();
      }

     
      final response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        data: userMetadata, 
      );
      
      if (response.session == null && response.user != null) {
        Get.toNamed(AppRoutes.verifyCode,
            arguments: {'email': emailController.text.trim()});
        Get.snackbar(
            'الخطوة التالية', 'تم إنشاء حسابك! الرجاء التحقق من بريدك الإلكتروني.');
      }
      else if (response.session != null) {
        if (userRole.value == UserType.provider) {
          Get.offAllNamed(AppRoutes.providerHome);
        } else {
          Get.offAllNamed(AppRoutes.home);
        }
        Get.snackbar('نجاح', 'تم إنشاء حسابك وتسجيل دخولك بنجاح.');
      }

    } on AuthException catch (e) {
      Get.snackbar('خطأ في إنشاء الحساب', e.message);
    } catch (e) {
      Get.snackbar('خطأ غير متوقع', e.toString()); 
    } finally {
      isLoading.value = false;
    }
  }
}

