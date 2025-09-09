import 'package:abshr/controler/auth/login_controlls.dart';
import 'package:get/get.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}