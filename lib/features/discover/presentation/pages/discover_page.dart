import 'package:flutter/material.dart';
import 'package:thedailynews/core/theme/app_colors.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(child: Text('Discover Page')),
    );
  }
}
