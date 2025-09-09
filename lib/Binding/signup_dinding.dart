import 'package:abshr/controler/auth/signup_controller.dart';
import 'package:get/get.dart';


class SignupDinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}