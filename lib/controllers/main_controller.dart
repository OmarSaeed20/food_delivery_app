import 'package:flutter/cupertino.dart';
import '../index.dart';

class MainController extends GetxController {
  int index = 0;
  List<Widget> pages = [
    const HomePage(),
    const OrdersPage(),
    const FavoritesPage(),
    const SettingsPage(),
  ];
  List<String> titles = [
    'Explore',
    'Orders',
    'Favorites',
    'Settings',
  ];
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: 'Explore',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.bag),
      label: 'Orders',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.heart),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.gear),
      label: 'Settings',
    ),
  ];
  void onTapNav(int val) {
    index = val;
    update();
  }
}
