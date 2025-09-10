import 'package:abshr/app_route.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  final supabase = Supabase.instance.client;


  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      Get.offAllNamed(AppRoutes.selection);

    } catch (e) {
      Get.snackbar(
        'خطأ في تسجيل الخروج',
        'حدث خطأ ما، يرجى المحاولة مرة أخرى.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}