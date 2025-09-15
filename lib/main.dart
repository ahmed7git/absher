import 'package:abshr/app_route.dart';
import 'package:abshr/constants/app_thems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Supabase.initialize(
    url: 'https://awhrlbozlzrpsbjysdwb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF3aHJsYm96bHpycHNianlzZHdiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc0MTkxOTQsImV4cCI6MjA3Mjk5NTE5NH0.FD2YJzotUNQkVhcf90t3JXLSW2DzqT3THihyjNM3CYo',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box('settings');
    final isDarkMode = settingsBox.get('isDarkMode', defaultValue: false);

    return GetMaterialApp(
      title: 'أبشر',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
       
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData( 
         primaryColor: AppColors.primaryGreen,
         scaffoldBackgroundColor: AppColors.backgroundPrimary,
         fontFamily: GoogleFonts.cairo().fontFamily,
         brightness: Brightness.light,
         cardColor: AppColors.backgroundCard,
      ),
      darkTheme: ThemeData( 
        primaryColor: AppColors.primaryGreen,
        scaffoldBackgroundColor: AppColors.darkBackground,
        fontFamily: GoogleFonts.cairo().fontFamily,
        brightness: Brightness.dark,
        cardColor: AppColors.darkCard, 
      ),
      
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.splash,
    );
  }
}
