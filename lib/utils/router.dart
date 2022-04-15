import 'package:flutter/material.dart';
import 'package:salla/ui/screens/auth/screens/login_screen.dart';
import 'package:salla/ui/screens/auth/screens/register_screen.dart';
import 'package:salla/ui/screens/category/screens/category_screen.dart';
import 'package:salla/ui/screens/category/screens/home_screen.dart';
import 'package:salla/ui/screens/category/screens/main_layout_screen.dart';
import 'package:salla/ui/screens/category/screens/search_sreen.dart';
import 'package:salla/ui/screens/category/screens/setting_screen.dart';
import 'package:salla/ui/screens/on_bording/on_bording_screen.dart';
import 'package:salla/ui/screens/splash/splash_screen.dart';
import 'package:salla/utils/routes_path.dart';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case SPLASH_ROUTE:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case ONBORDING_ROUTE:
        return MaterialPageRoute(builder: (_) =>  OnBoardingScreen());

      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());

      case REGISTER_ROUTE:
        return MaterialPageRoute(builder: (_) =>  RegisterScreen());

      case CATEGORIES_ROUTE:
        return MaterialPageRoute(builder: (_) =>  CategoryScreen());

      case SEARCH_ROUTE:
        return MaterialPageRoute(builder: (_) =>  SearchScreen());

      case SETTINGS_ROUTE:
        return MaterialPageRoute(builder: (_) =>  SettingsScreen());

      case MAIN_LAYOUT_ROUTE:
        return MaterialPageRoute(builder: (_) =>  MainLayoutScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Not found'),
            ),
          ),
        );
    }
  }
}
