import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubit/states.dart';
import 'package:salla/layout/shop_layout.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';
import 'package:salla/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'modules/login/shop_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  bool isLogin = CacheHelper.getData(key: 'IS_LOGIN');

  Widget widget = isLogin ? const ShopLayout() : ShopLoginScreen();

  runApp(MyApp(isDark: isDark,startWidget: widget));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  final Widget startWidget;

  const MyApp({super.key, required this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}


