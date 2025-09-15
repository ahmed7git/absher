import 'package:abshr/controler/forgetpassword/update_pass.dart';
import 'package:get/get.dart';

class UpdatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePasswordController>(() => UpdatePasswordController());
  }
}
