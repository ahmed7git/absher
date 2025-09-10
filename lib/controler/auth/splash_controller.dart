import 'dart:async';
import 'package:abshr/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;
  late StreamSubscription<AuthState> _authStateSubscription;

  late AnimationController animationController;
  late Animation<Offset> topCircleAnimation;
  late Animation<Offset> bottomCircleAnimation;
  late Animation<double> logoAnimation;

  @override
  void onInit() {
    super.onInit();
    _setupAnimations();
    _setupAuthListener();
  }

  void _setupAnimations() {
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    topCircleAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    bottomCircleAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (supabase.auth.currentUser == null) {
          Get.offNamed(AppRoutes.selection);
        }
      }
    });
  }

  void _setupAuthListener() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      if (session != null) {
        Get.offAllNamed(AppRoutes.home);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    if (supabase.auth.currentUser == null) {
      animationController.forward();
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    _authStateSubscription.cancel();
    super.onClose();
  }
}
