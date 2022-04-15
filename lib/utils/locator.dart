import 'package:get_it/get_it.dart';
import 'package:salla/core/services/web_service.dart';
import 'package:salla/ui/screens/auth/viewmodels/auth_viewmodel.dart';
import 'package:salla/ui/screens/category/models/change_fav_response.dart';
import 'package:salla/ui/screens/category/viewmodels/categories_viewmodel.dart';
import 'package:salla/ui/screens/category/viewmodels/favorate_viewmodel.dart';
import 'package:salla/ui/screens/category/viewmodels/home_viewmodel.dart';
import 'navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WebService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => CategoriesViewModel());
  locator.registerLazySingleton(() => FavoritesViewModel());

}
