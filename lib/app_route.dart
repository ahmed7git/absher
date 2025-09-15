import 'package:abshr/Binding/ForgotPasswordBinding.dart';
import 'package:abshr/Binding/Home_binding.dart';
import 'package:abshr/Binding/Profile_Binding.dart';
import 'package:abshr/Binding/Provider_Home_Binding.dart';
import 'package:abshr/Binding/UpdatePasswordBinding.dart';
import 'package:abshr/Binding/auth_selection_binding..dart';
import 'package:abshr/Binding/login_binding.dart';
import 'package:abshr/Binding/signup_dinding.dart';
import 'package:abshr/Binding/splash_binding.dart';
import 'package:abshr/Binding/verify_password_reset_binding.dart';
import 'package:abshr/Binding/verfiycode_binding.dart';
import 'package:abshr/Middleware/Middleware.dart';
import 'package:abshr/screens/Forgetpass/Forgot_Password_Screen.dart';
import 'package:abshr/screens/Forgetpass/Update_pass.dart';
import 'package:abshr/screens/Forgetpass/verify_password_reset_screen.dart';
import 'package:abshr/screens/auth/Auth_selection_screen.dart';
import 'package:abshr/screens/auth/login_screen.dart';
import 'package:abshr/screens/auth/signup_screen.dart';
import 'package:abshr/screens/auth/splashscreen.dart';
import 'package:abshr/screens/auth/verfiycode.dart';
import 'package:abshr/screens/home/Provider_Home_Screen.dart';
import 'package:abshr/screens/home/home.dart';
import 'package:abshr/screens/home/profile_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/';
  static const String selection = '/selection';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String verifyCode = '/verify-code';
  static const String home = '/home';
  static const String profilescreen = '/ProfileScreen';
  static const String providerHome = '/provider-home';
  static const String forgotPassword = '/forgot-password';

  static const String verifyPasswordReset = '/verify-password-reset';

  static const String updatePassword = '/update-password';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: selection,
      page: () => const AuthSelectionScreen(),
      binding: AuthSelectionBinding(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpScreen(),
      binding: SignupDinding(),
    ),
    GetPage(
      name: verifyCode,
      page: () => const VerifyCodeScreen(),
      binding: VerfiycodeBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: profilescreen,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: providerHome,
      page: () => const ProviderHomeScreen(),
      binding: ProviderHomeBinding(),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: verifyPasswordReset,
      page: () => const VerifyPasswordResetScreen(),
      binding: VerifyPasswordResetBinding(),
    ),
    GetPage(
      name: updatePassword,
      page: () => const UpdatePasswordScreen(),
      binding: UpdatePasswordBinding(),
    ),
  ];
}

