import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:salla/ui/shared/values.dart';

class WebService {
  static const BASE_URL = "https://student.valuxapps.com";
  static const API_URL = "$BASE_URL/api/";

  Future<Map<String, dynamic>> getRequest(String url,
      {Map<String, dynamic>? queryParams,
      String? token,
      String? lang = Values.APP_LANG  }) async {
    String queryString = "";
    if (queryParams != null) {
      queryString = "?" + Uri(queryParameters: queryParams).query;
    }
    var requestUrl = API_URL + url + queryString;
    print(requestUrl);
    Map<String, dynamic> result = {};
    try {
      var response = await http.get(Uri.parse(requestUrl),
      headers: {
        'lang':lang??'',
        'Authorization': token??'',
        'Content-Type': 'application/json',
      });
      print(utf8.decode(response.bodyBytes).toString());
      if (response.statusCode == HttpStatus.ok) {
        result.putIfAbsent("state", () => true);
        result.putIfAbsent(
            "data", () => utf8.decode(response.bodyBytes).toString());
      } else {
        result.putIfAbsent("state", () => false);
        result.putIfAbsent(
            "data", () => utf8.decode(response.bodyBytes).toString());
        result.putIfAbsent("error", () => 'Server error');
      }
    } catch (ex) {
      print(ex);
      result.putIfAbsent("state", () => false);
      result.putIfAbsent("error", () => 'Server error');
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        result["error"] = 'No connection';
      }
    }
    return result;
  }

  Future<Map<String, dynamic>> postRequest(String url,
      {Map<String, dynamic>? queryParams, dynamic body}) async {

    String queryString = "";
    var data = body != null ? json.encode(body) : null;
    print(data);
    if (queryParams != null) {
      queryString = "?" +
          Uri.decodeQueryComponent(Uri(queryParameters: queryParams).query);
    }
    var requestUrl = API_URL + url + queryString;
    Map<String, dynamic> result = {};
    try {
      var response =
      await http.post(Uri.parse(requestUrl), body: data);
      print(utf8.decode(response.bodyBytes).toString());
      if (response.statusCode == HttpStatus.ok) {
        result.putIfAbsent("state", () => true);
        result.putIfAbsent(
            "data", () => utf8.decode(response.bodyBytes).toString());
      } else {
        result.putIfAbsent("state", () => false);
        result.putIfAbsent(
            "data", () => utf8.decode(response.bodyBytes).toString());
        result.putIfAbsent("error", () => 'Server error');
      }
    } catch (ex) {
      result.putIfAbsent("state", () => false);
      result.putIfAbsent("error", () => 'Server error');
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        result["error"] = 'No connection';
      }
    }

    return result;
  }
}