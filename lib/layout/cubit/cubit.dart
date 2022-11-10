
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubit/states.dart';

import '../../models/categories_model.dart';
import '../../models/change_favorites_model.dart';
import '../../models/favorites_model.dart';
import '../../models/home_model.dart';
import '../../models/login_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel =HomeModel();

  Map<int?, bool?> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      //print(homeModel.data.banners[0].image);
      //print(homeModel.status);

      for (var element in homeModel.data!.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      }

      //print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel = CategoriesModel();

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel =ChangeFavoritesModel();

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (changeFavoritesModel.status ==false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel =FavoritesModel();

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel userModel = ShopLoginModel();

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
    });
  }


  bool isDark = false;
  void changeAppMode({required bool fromShared})
  {
    if (fromShared)
    {
      isDark = fromShared;
      emit(ShopChangeModeState());
    } else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ShopChangeModeState());
      });
    }
  }


}
