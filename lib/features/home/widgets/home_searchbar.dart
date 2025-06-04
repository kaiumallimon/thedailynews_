import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thedailynews/core/theme/app_colors.dart';
import 'package:thedailynews/features/wrapper/Provider/navigation_provider.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to search page
        Provider.of<NavigationProvider>(
          context,
          listen: false,
        ).selectTab(NavItem.discover);
        context.go('/discover');
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Search here',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textHintColor,
                  fontFamily: GoogleFonts.sora().fontFamily,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Icon(CupertinoIcons.search, color: AppColors.iconColor),
          ],
        ),
      ),
    );
  }
}
