import 'package:abshr/app_route.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProviderHomeController extends GetxController {
  final supabase = Supabase.instance.client;

  final RxList<Map<String, String>> orders = <Map<String, String>>[
    {
      'service_name': 'توصيل طرد',
      'pickup_address': 'المنصورة',
      'dropoff_address': 'خور مكسر',
      'time': 'قبل 5 دقائق'
    },
    {
      'service_name': 'شحن بضائع',
      'pickup_address': 'المعلا',
      'dropoff_address': 'الشيخ عثمان',
      'time': 'قبل 20 دقيقة'
    },
  ].obs;

  Future<void> signOut() async {
    await supabase.auth.signOut();
    Get.offAllNamed(AppRoutes.selection);
  }
}
