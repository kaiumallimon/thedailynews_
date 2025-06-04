import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:thedailynews/core/theme/app_colors.dart';
import 'package:thedailynews/shared/widgets/app_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        context.go('/home');
      }
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: AppLogo(theme: theme)),

          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: CupertinoActivityIndicator(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
