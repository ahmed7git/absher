import 'package:abshr/controler/forgetpassword/verify_password_reset_controller.dart';
import 'package:get/get.dart';

class VerifyPasswordResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyPasswordResetController>(
        () => VerifyPasswordResetController());
  }
}