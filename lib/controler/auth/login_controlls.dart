import 'package:abshr/app_route.dart';
import 'package:abshr/controler/auth/auth_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  final _localAuth = LocalAuthentication();
  final _settingsBox = Hive.box('settings');

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  UserType? userRole;
  final RxString screenTitle = 'تسجيل الدخول'.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      userRole = Get.arguments['role'];
      screenTitle.value = Get.arguments['title'] ?? 'تسجيل الدخول';
    }

    emailController = TextEditingController();
    passwordController = TextEditingController();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutQuint,
    ));

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!isClosed) {
        animationController.forward();
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    animationController.dispose();
    super.onClose();
  }

  void navigateToSignUp() {
    Get.toNamed(AppRoutes.signUp, arguments: {
      'role': userRole.toString(),
    });
  }

  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }
    if (!GetUtils.isEmail(value)) {
      return 'الرجاء إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    isLoading.value = true;

    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (res.user == null) {
        Get.snackbar('خطأ', 'فشل تسجيل الدخول، يرجى التحقق من بياناتك.');
        isLoading.value = false;
        return;
      }

      final user = res.user!;
      final profileResponse = await supabase
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .single();

      final String dbRole = profileResponse['role'];
      final String expectedRole = userRole.toString().split('.').last;

      if (dbRole == expectedRole) {
        if (dbRole == 'provider') {
          Get.offAllNamed(AppRoutes.providerHome);
        } else {
          Get.offAllNamed(AppRoutes.home);
        }
      } else {
        await supabase.auth.signOut();
        Get.snackbar(
          'خطأ في الدخول',
          'هذا الحساب ليس من نوع "${screenTitle.value}". الرجاء اختيار الهوية الصحيحة.',
        );
      }
    } on AuthException catch (e) {
      Get.snackbar('خطأ في تسجيل الدخول', e.message);
    } catch (e) {
      await supabase.auth.signOut();
      Get.snackbar('خطأ غير متوقع', 'حدث خطأ ما، يرجى المحاولة مرة أخرى.');
    } finally {
      isLoading.value = false;
    }
  }
  

  Future<void> signInWithGoogle() async {

    Get.snackbar('قيد التطوير', 'تسجيل الدخول عبر جوجل غير متاح حالياً.');
  }
 

  Future<void> signInWithBiometrics() async {
    final isBiometricEnabled =
        _settingsBox.get('isBiometricEnabled', defaultValue: false);
    if (!isBiometricEnabled) {
      Get.snackbar(
        'البصمة غير مفعلة',
        'الرجاء تفعيل القفل بالبصمة من صفحة الملف الشخصي أولاً.',
      );
      return;
    }

    final refreshToken = _settingsBox.get('biometricRefreshToken');
    if (refreshToken == null) {
      Get.snackbar(
        'خطأ',
        'لم يتم العثور على بيانات تسجيل الدخول بالبصمة. الرجاء تسجيل الدخول بكلمة المرور وتفعيل البصمة مرة أخرى.',
      );
      return;
    }

    try {
      final canAuthenticate = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();

      if (canAuthenticate) {
        final didAuthenticate = await _localAuth.authenticate(
          localizedReason: 'الرجاء المصادقة لتسجيل الدخول',
          options:
              const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
        );

        if (didAuthenticate) {
          isLoading.value = true;
          final response =
              await supabase.auth.setSession(refreshToken);

          if (response.user != null) {
            final role = _settingsBox.get('biometricUserRole');
            if (role == 'provider') {
              Get.offAllNamed(AppRoutes.providerHome);
            } else {
              Get.offAllNamed(AppRoutes.home);
            }
          } else {
             Get.snackbar('خطأ في المصادقة',
                'فشل استعادة الجلسة. قد تكون كلمة المرور قد تغيرت. الرجاء الدخول بكلمة المرور.');
          }
        }
      } else {
        Get.snackbar('غير مدعوم', 'جهازك لا يدعم المصادقة الحيوية.');
      }
    } on AuthException catch(e) {
        if (e.message.contains('Invalid Refresh Token')) {
           Get.snackbar('خطأ في المصادقة',
                'جلسة الدخول بالبصمة لم تعد صالحة. الرجاء تسجيل الدخول بكلمة المرور لمزامنة البصمة.');
        } else {
           Get.snackbar('خطأ', 'حدث خطأ: ${e.message}');
        }
    } 
    on PlatformException catch (e) {
      if (e.code != 'auth_in_progress' &&
          e.code != 'user_cancel' &&
          e.code != 'SystemCancel') {
        Get.snackbar('خطأ', 'حدث خطأ غير متوقع: ${e.message}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}

