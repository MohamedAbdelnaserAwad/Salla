import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:salla/core/services/web_service.dart';
import 'package:salla/utils/locator.dart';
import 'package:salla/utils/navigation_service.dart';

class BaseViewModel extends ChangeNotifier {
  bool isLoading = false;
  final navigation = locator<NavigationService>();
  final webService = locator<WebService>();

  showLoading() {
    EasyLoading.show();
    isLoading = true;
    notifyListeners();
  }

  hideLoading() {
    EasyLoading.dismiss();
    isLoading = false;
    notifyListeners();
  }

  showError(String error) {
    if (error.isNotEmpty) navigation.showError(error);
  }
}
