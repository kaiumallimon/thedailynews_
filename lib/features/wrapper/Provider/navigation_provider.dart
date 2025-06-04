import 'package:flutter/material.dart';

enum NavItem { home, discover, categories }


class NavigationProvider extends ChangeNotifier{
  NavItem _selectedItem = NavItem.home;

  NavItem get selectedItem => _selectedItem;

  void selectTab(NavItem item) {
    if (_selectedItem != item) {
      _selectedItem = item;
      notifyListeners();
    }
  }

  void reset() {
    _selectedItem = NavItem.home;
    notifyListeners();
  }
}