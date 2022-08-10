import 'dart:convert';
import 'dart:io';

import 'package:clover_construction/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/static_urls.dart';

class ProfileProvider with ChangeNotifier {
  var _userProfile = Profile(
    0,
    "",
    "",
    "",
    "",
    "",
    DateTime.now(),
    "",
  );

  Profile userProfile() {
    return _userProfile;
  }

  Future<void> fetchUserProfile(int userId) async {
    final url = "$profileUrl$userId/";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode >= 400) {
        throw const HttpException("Something Went Wrong");
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        print(extractedData);
        if (extractedData != null) {
          _userProfile = Profile(
            extractedData['id'],
            extractedData['username'],
            extractedData['email'],
            extractedData['full_name'],
            extractedData['phone_no'],
            extractedData['address'],
            DateTime.parse(extractedData['date_of_birth']),
            extractedData['profile_photo'],
          );
          notifyListeners();
        }else{
          print("Something Went Wrong!");
          return;
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
