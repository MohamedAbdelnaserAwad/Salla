import 'dart:convert';

import 'package:salla/core/viewmodels/base_view_model.dart';
import 'package:salla/ui/screens/category/models/categories_response.dart';
import 'package:salla/ui/shared/values.dart';
import 'package:salla/utils/api_constants.dart';

class CategoriesViewModel extends BaseViewModel{

   CategoriesResponse? categories;

  get data => null;

  void getCategories() async {
    Map<String, dynamic> response = {};
    CategoriesResponse? categoriesResponse;

    try {
      showLoading();
      response =
      await webService.getRequest(ApiConstants.CATEGORIES_URL,
          token: Values.token,
          lang: Values.APP_LANG,);

      hideLoading();

      categoriesResponse = CategoriesResponse.fromJson(json.decode(response['data']));

      if (categoriesResponse.status ?? false) {
        categories = categoriesResponse;
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

}