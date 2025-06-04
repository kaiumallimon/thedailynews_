import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thedailynews/core/theme/app_colors.dart';
import 'package:thedailynews/core/utils/greetings.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Text(
        generateGreeting(),
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: 17,
          color: AppColors.textColor.withAlpha(150),
          fontWeight: FontWeight.normal,
          fontFamily: GoogleFonts.sora().fontFamily,
        ),
      ),
    );
  }
}
