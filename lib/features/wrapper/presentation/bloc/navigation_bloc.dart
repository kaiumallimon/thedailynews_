import 'package:flutter_bloc/flutter_bloc.dart';

enum NavItem { home, discover, categories, profile }

class NavigationBloc extends Cubit<NavItem> {
  NavigationBloc() : super(NavItem.home);

  void selectTab(NavItem item) {
    emit(item);
  }
}
