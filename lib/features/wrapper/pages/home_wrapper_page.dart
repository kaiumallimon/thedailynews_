import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:thedailynews/core/theme/app_colors.dart';
import 'package:thedailynews/features/wrapper/Provider/navigation_provider.dart';

class HomeWrapperPage extends StatelessWidget {
  const HomeWrapperPage({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Set the system UI overlay style for the home wrapper page
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, _) {
        final currentIndex = _indexFromTab(navigationProvider.selectedItem);
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: child,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withOpacity(0.3), // 👈 Adjust color here
                  width: 1.0,
                ),
              ),
            ),
            child: NavigationBar(
              backgroundColor: AppColors.white,
              selectedIndex: currentIndex,
              surfaceTintColor: Colors.transparent,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              indicatorColor: AppColors.primary,
              onDestinationSelected: (index) {
                final selectedTab = _tabFromIndex(index);
                navigationProvider.selectTab(selectedTab);
                context.go(_routeFromTab(selectedTab));
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Icons.home,
                    color: currentIndex == 0
                        ? AppColors.white
                        : AppColors.textColor,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.search,
                    color: currentIndex == 1
                        ? AppColors.white
                        : AppColors.textColor,
                  ),
                  label: 'Discover',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.newspaper,
                    color: currentIndex == 2
                        ? AppColors.white
                        : AppColors.textColor,
                  ),
                  label: 'Categories',
                ),
                // NavigationDestination(
                //   icon: Icon(
                //     Icons.person,
                //     color: currentIndex == 3
                //         ? AppColors.white
                //         : AppColors.textColor,
                //   ),
                //   label: 'Profile',
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _indexFromTab(NavItem item) {
    switch (item) {
      case NavItem.home:
        return 0;
      case NavItem.discover:
        return 1;
      case NavItem.categories:
        return 2;
      // case NavItem.profile:
      //   return 3;
    }
  }

  NavItem _tabFromIndex(int index) {
    return NavItem.values[index];
  }

  String _routeFromTab(NavItem tab) {
    switch (tab) {
      case NavItem.home:
        return '/home';
      case NavItem.discover:
        return '/discover';
      case NavItem.categories:
        return '/categories';
      // case NavItem.profile:
      //   return '/profile';
    }
  }
}
