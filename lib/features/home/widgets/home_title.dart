import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thedailynews/core/theme/app_colors.dart';

class HomeTitle extends StatelessWidget {
  final ThemeData theme;

  const HomeTitle({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Explore Today's\n",
              style: theme.textTheme.headlineMedium?.copyWith(
                color: AppColors.titleTextColor,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.sora().fontFamily,
              ),
            ),
            TextSpan(
              text: "News Worldwide",
              style: theme.textTheme.headlineMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.sora().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
