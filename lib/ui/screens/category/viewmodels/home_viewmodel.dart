import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:salla/core/viewmodels/base_view_model.dart';
import 'package:salla/ui/screens/category/models/categories_response.dart';
import 'package:salla/ui/screens/category/models/home_response.dart';
import 'package:salla/ui/screens/category/screens/category_screen.dart';
import 'package:salla/ui/screens/category/screens/favorates_screen.dart';
import 'package:salla/ui/screens/category/screens/home_screen.dart';
import 'package:salla/ui/screens/category/screens/setting_screen.dart';
import 'package:salla/ui/screens/category/viewmodels/favorate_viewmodel.dart';
import 'package:salla/ui/shared/values.dart';
import 'package:salla/utils/api_constants.dart';

class HomeViewModel extends BaseViewModel{

   HomeResponse? home;
   int currentIndex = 0;


  void getCategories() async {
    Map<String, dynamic> response = {};
     HomeResponse? homeResponse;

    try {
      showLoading();
      response =
      await webService.getRequest(ApiConstants.HOME_URL,
      token: Values.token,
        lang: Values.APP_LANG,);

      hideLoading();

      homeResponse = HomeResponse.fromJson(json.decode(response['data']));

      homeResponse.data!.products.forEach((element) {
        FavoritesViewModel.favoritesMap.addAll({
          element.id: element.inFavorites,
        });
      });

      if (homeResponse.status ?? false) {
        home = homeResponse;

      } else {
        showError("Categories Not Found");
      }
      notifyListeners();
    } catch (ex) {
      hideLoading();
      String error = response['error'] ?? "Server error";
      showError(error);
    }
  }

   List<Widget> bottomScreens = [
     HomeScreen(),
     CategoryScreen(),
     FavoritesScreen(),
     SettingsScreen(),
   ];

   void changeBottom(int index) {
     currentIndex = index;
   }

}