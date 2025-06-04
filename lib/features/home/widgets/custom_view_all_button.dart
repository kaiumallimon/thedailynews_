import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thedailynews/core/theme/app_colors.dart';

class CustomViewAllButton extends StatelessWidget {
  const CustomViewAllButton({
    super.key,
    required this.theme,
    required this.onTap,
  });

  final ThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'View All',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.textHintColor,
          fontFamily: GoogleFonts.sora().fontFamily,
        ),
      ),
    );
  }
}
