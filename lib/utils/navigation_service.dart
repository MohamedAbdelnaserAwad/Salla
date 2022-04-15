import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:salla/ui/shared/app_colors.dart';
import 'package:salla/ui/shared/text_style.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> push(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacement(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  // void popToHome() {
  //   navigatorKey.currentState!.popUntil(ModalRoute.withName((MAIN_ROUTE)));
  // }

  Future<dynamic> pushNamedAndRemoveUntil(String newRoute, int popUntil,
      {dynamic arguments}) {
    int count = 0;
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        newRoute, (_) => count++ >= popUntil,
        arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }

  void showError(String error) {
    try {
      //showErrorSnackBar(error, navigatorKey.currentContext!);

      BotToast.showSimpleNotification(
          title: error,
          backgroundColor: errorColor,
          titleStyle: errorTextStyle,
          hideCloseButton: true,
          duration: Duration(seconds: 3));
    } catch (ex) {
      print(ex);
    }
  }
}
