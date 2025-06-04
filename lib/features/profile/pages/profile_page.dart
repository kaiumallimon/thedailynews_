import 'package:flutter/material.dart';
import 'package:thedailynews/core/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(child: Text('Welcome to the Profile Page')),
    );
  }
}
