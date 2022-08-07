import 'dart:convert';
import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/models/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  Map<String, dynamic> _userInfo= {
    "userId": 0,
    "username": "",
    "email": "",
    "token": "",
  };

  get userInfo{
    return {..._userInfo};
  }
  
  Future<void> register(String username, String password, String fullName,
      String phoneNumber, String email) async {
    const url = userRegister;
    try {
      final response = await http.post(Uri.parse(url), body: {
        "username": username,
        "password": password,
        "full_name": fullName,
        "phone_no": phoneNumber,
        "email": email,
      });
      var responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 400) {
        throw HttpException("Unable to Register with provided credentials");
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String username, String password) async {
    const url = userLogin;
    try {
      final response = await http.post(Uri.parse(url),
          body: {"username": username, "password": password});
      var responseData = json.decode(response.body);
      if (response.statusCode == 400) {
        throw HttpException("Unable to Login with provided credentials");
      }
      _userInfo['userId'] = responseData['user-info']['id'];
      _userInfo['username'] = responseData['user-info']['username'];
      _userInfo['email'] = responseData['user-info']['email'];
      _userInfo['token'] = responseData['token'];
    } catch (error) {
      throw error;
    }
  }
}
