import 'package:abshr/controler/auth/verfiycode_controller.dart';
import 'package:get/get.dart';


class VerfiycodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyCodeController>(() => VerifyCodeController());
  }
}