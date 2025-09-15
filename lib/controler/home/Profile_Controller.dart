import 'package:abshr/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;
  final _settingsBox = Hive.box('settings');
  final _localAuth = LocalAuthentication();

  late AnimationController animationController;
  late Animation<double> profileInfoAnimation;
  late Animation<double> settingsAnimation;

  var isDarkMode = false.obs;
  var isBiometricEnabled = false.obs;

  final userName = ''.obs;
  final userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
    _loadUserData();
    _setupAnimations();
  }

  void _setupAnimations() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    profileInfoAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    settingsAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );
    animationController.forward();
  }

  void _loadSettings() {
    isDarkMode.value =
        _settingsBox.get('isDarkMode', defaultValue: Get.isDarkMode);
    isBiometricEnabled.value =
        _settingsBox.get('isBiometricEnabled', defaultValue: false);
  }

  void _loadUserData() {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      userName.value =
          currentUser.userMetadata?['full_name'] ?? 'اسم المستخدم';
      userEmail.value = currentUser.email ?? 'البريد الإلكتروني';
    }
  }

  void changeTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    _settingsBox.put('isDarkMode', value);
  }

  Future<void> toggleBiometrics(bool enable) async {
    if (enable) {
      try {
        final canAuthenticate = await _localAuth.canCheckBiometrics ||
            await _localAuth.isDeviceSupported();

        if (canAuthenticate) {
          final didAuthenticate = await _localAuth.authenticate(
            localizedReason: 'الرجاء المصادقة لتفعيل الدخول بالبصمة',
            options: const AuthenticationOptions(
                stickyAuth: true, biometricOnly: true),
          );

          if (didAuthenticate) {
            final session = supabase.auth.currentSession;
            final user = supabase.auth.currentUser;
            
            if (user != null && (session?.refreshToken?.isNotEmpty ?? false)) {
              final profileResponse = await supabase
                  .from('profiles')
                  .select('role')
                  .eq('id', user.id)
                  .single();
              final role = profileResponse['role'];

              await _settingsBox.put('biometricRefreshToken', session!.refreshToken);
              await _settingsBox.put('biometricUserRole', role);
              await _settingsBox.put('isBiometricEnabled', true);
              isBiometricEnabled.value = true; 
              Get.snackbar(
                  'تم التفعيل', 'تم تفعيل القفل باستخدام البصمة بنجاح.');
            } else {
              Get.snackbar('خطأ في التفعيل',
                  'فشل حفظ جلسة البصمة. الرجاء تسجيل الخروج والدخول مرة أخرى ثم المحاولة.');
              isBiometricEnabled.value = false;
            }
          } else {
             isBiometricEnabled.value = false;
          }
        } else {
          Get.snackbar('غير مدعوم', 'جهازك لا يدعم المصادقة الحيوية.');
          isBiometricEnabled.value = false;
        }
      } on PlatformException catch (e) {
        Get.snackbar('خطأ', 'حدث خطأ أثناء تفعيل البصمة: ${e.message}');
        isBiometricEnabled.value = false;
      }
    } else {
      await _settingsBox.delete('biometricRefreshToken');
      await _settingsBox.delete('biometricUserRole');
      await _settingsBox.put('isBiometricEnabled', false);
      isBiometricEnabled.value = false;
      Get.snackbar('تم الإلغاء', 'تم إلغاء تفعيل القفل باستخدام البصمة.');
    }
  }

  void changePassword() {
    Get.toNamed(AppRoutes.updatePassword, arguments: {'fromProfile': true});
  }

Future<void> signOut() async {
    Get.offAllNamed(AppRoutes.selection);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

