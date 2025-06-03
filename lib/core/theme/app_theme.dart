import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thedailynews/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData theme() => ThemeData(
    textTheme: GoogleFonts.soraTextTheme(),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primary,
  );
}
