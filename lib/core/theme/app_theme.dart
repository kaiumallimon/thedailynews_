import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thedailynews/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData theme() => ThemeData(
    textTheme: GoogleFonts.soraTextTheme(),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primary,
    primaryColorLight: AppColors.primary,
    fontFamily: GoogleFonts.sora().fontFamily,
    colorScheme:
        ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: AppColors.secondary,
          brightness: Brightness.dark,
        ).copyWith(
          secondary: AppColors.secondary,
          surface: AppColors.scaffoldBackground,
          background: AppColors.scaffoldBackground,
          error: Colors.red,
        ),
  );
}
