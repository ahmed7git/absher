import 'package:abshr/controler/home/provider_home_controller.dart';
import 'package:get/get.dart';

class ProviderHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderHomeController>(() => ProviderHomeController());
  }
}
