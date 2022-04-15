import 'dart:convert';

import 'package:salla/core/viewmodels/base_view_model.dart';
import 'package:salla/ui/screens/category/models/change_fav_response.dart';
import 'package:salla/ui/screens/category/models/favorates_response.dart';
import 'package:salla/ui/shared/values.dart';
import 'package:salla/utils/api_constants.dart';

class FavoritesViewModel extends BaseViewModel{

  static FavoritesResponse? favorites;
  static Map<dynamic, dynamic> favoritesMap = {};

  get data => null;

  void getFavorites() async {
    Map<String, dynamic> response = {};
    FavoritesResponse? favoritesResponse;

    try {
      showLoading();
      response =
      await webService.getRequest(ApiConstants.FAVORATES_URL,
      token: Values.token,
        lang: Values.APP_LANG,);

      hideLoading();

      favoritesResponse = FavoritesResponse.fromJson(json.decode(response['data']));

      if (favoritesResponse.status ?? false) {
        favorites = favoritesResponse;
      } else {
        showError("Favorites Not Found");
      }
      notifyListeners();
    } catch (ex) {
      hideLoading();
      String error = response['error'] ?? "Server error";
      showError(error);
    }
  }


  ChangeFavoritesResponse? changeFavoritesModel;

  void changeFavorites(int productId) {
   bool temp = favoritesMap![productId];
    favoritesMap[productId] =! favoritesMap![productId];


    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      emit(ShopErrorChangeFavoritesState());
    });
  }

}