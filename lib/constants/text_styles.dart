
import 'package:flutter/material.dart';
import 'package:abshr/constants/app_thems.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle get headlineLarge => GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get headlineMedium => GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get bodySmall => GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get buttonText => GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  
  static TextStyle get labelText => GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

    static TextStyle get caption => GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
  );
}