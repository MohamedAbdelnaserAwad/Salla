import 'dart:convert';

import 'package:salla/core/services/shared_prefrence_manager.dart';
import 'package:salla/core/viewmodels/base_view_model.dart';
import 'package:salla/ui/screens/auth/models/login_response.dart';
import 'package:salla/ui/screens/auth/models/register_response.dart';
import 'package:salla/ui/shared/values.dart';
import 'package:salla/utils/api_constants.dart';
import 'package:salla/utils/routes_path.dart';


class AuthViewModel extends BaseViewModel {

  void doLogin({required String email, required String password}) async {
    Map<String, dynamic> response = {};
    LoginResponse? loginResponse;

    try {
      showLoading();
      response =
      await webService.postRequest(ApiConstants.LOGIN_URL, queryParams: {
        'email': email,
        'password': password,
      });

      hideLoading();
      loginResponse = LoginResponse.fromJson(json.decode(response['data']));
      if (loginResponse.status ?? false) {
        SharedPrefs.saveData(
          key: 'token',
          value: loginResponse.data!.token,
        ).then((value) {
          Values.token =loginResponse!.data!.token.toString();
          SharedPrefs.saveData(key: 'token', value: Values.token);
          navigation.pushReplacement(MAIN_LAYOUT_ROUTE);
        });
      } else {
        showError(loginResponse.message ?? "Unauthorized");
      }
    } catch (ex) {
      hideLoading();
      String error = response['error'] ?? "Server error";
      showError(error);
    }
  }

  void doRegister(
      {required String email,
        required String password,
        required String name,
        required String phone}) async {
    Map<String, dynamic> response = {};
    RegisterResponse? registerResponse;

    try {
      showLoading();
      response =
      await webService.postRequest(ApiConstants.REGISTER_URL, queryParams: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      });

      hideLoading();
      registerResponse =
          RegisterResponse.fromJson(json.decode(response['data']));
      if (registerResponse.status ?? false) {
        navigation.pushReplacement(HOME_ROUTE);
      } else {
        showError("Email or Phone Already taken");
      }
    } catch (ex) {
      hideLoading();
      String error = response['error'] ?? "Server error";
      showError(error);
    }
  }
}
