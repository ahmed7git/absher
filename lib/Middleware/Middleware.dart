import 'package:abshr/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthMiddleware extends GetMiddleware {
  final supabase = Supabase.instance.client;

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final session = supabase.auth.currentSession;

    _checkUserRoleAndRedirect(session, route);

    return null;
  }

  Future<void> _checkUserRoleAndRedirect(Session? session, String? route) async {

    await Future.delayed(const Duration(milliseconds: 100));

    if (session == null) {
      Get.offAllNamed(AppRoutes.selection);
      return;
    }

    try {
      final user = session.user;
      final response = await supabase
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .single();

      final role = response['role'];

      if (role == 'provider' && route == AppRoutes.home) {

        Get.offAllNamed(AppRoutes.providerHome);
      } else if (role == 'user' && route == AppRoutes.providerHome) {
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      await supabase.auth.signOut();
      Get.offAllNamed(AppRoutes.selection);
    }
  }
}

