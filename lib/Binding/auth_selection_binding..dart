import 'package:abshr/controler/auth/auth_selection_controller.dart';
import 'package:get/get.dart';


class AuthSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthSelectionController>(() => AuthSelectionController());
  }
}