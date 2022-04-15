import 'package:flutter/material.dart';
import 'package:salla/core/services/shared_prefrence_manager.dart';
import 'package:salla/ui/screens/auth/screens/login_screen.dart';
import 'package:salla/ui/screens/category/screens/home_screen.dart';
import 'package:salla/ui/screens/category/screens/main_layout_screen.dart';
import 'package:salla/ui/screens/on_bording/on_bording_screen.dart';
import 'package:salla/ui/shared/app_colors.dart';
import 'package:salla/ui/shared/text_style.dart';
import 'package:salla/ui/shared/values.dart';
import 'package:salla/utils/common.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute:  navigate(),
      duration: 3000,
      imageSize: 190,
      imageSrc: imgPath+"splash.png",
      text: "Welcome to SALLA",
      textType: TextType.ScaleAnimatedText,
      textStyle: appBarTextStyle.copyWith(fontSize: 28),
      backgroundColor:lightBlueBackground,
    );
  }
  
  Widget navigate(){
    var onBoarding = SharedPrefs.getData(key: 'openedBefore');
    if(onBoarding != null){
      if(Values.token != null){
        print('home screen');
        return MainLayoutScreen();
      }else{
        print('login screen');
        return LoginScreen();
      }
    }else{
      print('onboarding screen');
      return OnBoardingScreen();
    }
    // if(onBoarding == false)
    // {
    //   if(token != false) return HomeScreen();
    //   else return LoginScreen();
    // } else
    // {
    //  return OnBoardingScreen();
    // }
  } 
  
}
