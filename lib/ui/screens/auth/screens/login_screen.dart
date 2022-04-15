import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/ui/screens/auth/viewmodels/auth_viewmodel.dart';
import 'package:salla/ui/shared/app_colors.dart';
import 'package:salla/ui/shared/text_style.dart';
import 'package:salla/utils/common.dart';
import 'package:salla/utils/locator.dart';
import 'package:salla/utils/navigation_service.dart';
import 'package:salla/utils/routes_path.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emilController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> fKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emilController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
          style: appBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: fKey,
            child: Column(
              children: [
                Image.asset(imgPath + 'logo.png', width: 180, height: 180),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  controller: emilController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You Must Enter Vaild Emil';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password must be not empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: MaterialButton(
                    onPressed: () {
                      if (fKey.currentState!.validate()) {
                        locator<AuthViewModel>().doLogin(
                            email: emilController.text,
                            password: passwordController.text);
                      }
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    color: blueColor2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have an Account?",
                    ),
                    TextButton(
                      onPressed: () {
                        locator<NavigationService>().pushReplacement(REGISTER_ROUTE);
                      },
                      child: const Text(
                        'Sign Up',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
