
import 'package:abshr/Binding/Home_binding.dart';
import 'package:abshr/Binding/auth_selection_binding..dart';
import 'package:abshr/Binding/login_binding.dart';
import 'package:abshr/Binding/signup_dinding.dart';
import 'package:abshr/Binding/splash_binding.dart';
import 'package:abshr/Binding/verfiycode_binding.dart';
import 'package:abshr/screens/auth/Auth_selection_screen.dart';
import 'package:abshr/screens/auth/login_screen.dart';
import 'package:abshr/screens/auth/signup_screen.dart';
import 'package:abshr/screens/auth/splashscreen.dart';
import 'package:abshr/screens/auth/verfiycode.dart';
import 'package:abshr/screens/home/home.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const String splash = '/';
  static const String selection = '/selection';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String verifyCode = '/verify-code';
  static const String home = '/home';


  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding:SplashBinding(),
    ),
    GetPage(
      name: selection,
      page: () => const AuthSelectionScreen(),
      binding:AuthSelectionBinding (),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding:LoginBinding (),
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpScreen(),
      binding:SignupDinding (),
    ),
    GetPage(
      name: verifyCode,
      page: () => const VerifyCodeScreen(),
      binding:VerfiycodeBinding (),
    ),
    GetPage(
      name: home,
      page: () => const Home(),
      binding:HomeBinding (),
    ),
    
  ];
}