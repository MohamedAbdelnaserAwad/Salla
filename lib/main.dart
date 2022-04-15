import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:salla/ui/shared/app_colors.dart';
import 'package:salla/utils/locator.dart';
import 'package:salla/utils/navigation_service.dart';
import 'package:salla/utils/routes_path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/shared_prefrence_manager.dart';
import 'package:salla/utils/router.dart' as router;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  //this line to clear shared pref =>
  //SharedPreferences.setMockInitialValues({});
  await sharedPrefs.init();
  runApp(const MyApp());
  configLoading();
}
void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.transparent
    ..boxShadow = <BoxShadow>[]
    ..textColor = Colors.white
    ..indicatorColor = darkGreen
    ..maskType = EasyLoadingMaskType.none
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salla',
      theme: ThemeData(
          fontFamily: 'ArabicUIText',
          primaryColor: blueColor2,
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: blueColor2),
          appBarTheme:AppBarTheme(
            titleSpacing: 20.0,
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),

      ),
      initialRoute: SPLASH_ROUTE,
      onGenerateRoute: router.Router.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      builder: EasyLoading.init(builder: BotToastInit()),
    );
  }
}

