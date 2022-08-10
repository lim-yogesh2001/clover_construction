import 'dart:convert';

import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/models/department.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DepartmentProvider with ChangeNotifier {
  List<Department> _departments = [];

  get departments {
    return [..._departments];
  }

  Department findById(int id){
    return _departments.firstWhere((element) => element.id == id);
  }

  Future<void> fetchDepartments() async {
    const url = "${departmentsApi}department-list/";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as List<dynamic>;
      final List<Department> loadedItems = [];
      if (extractedData.isEmpty) {
        return;
      }
      for (var element in extractedData) {
        loadedItems.insert(
            0,
            Department(
              id: element['id'],
              title: element['title'],
              imageUrl: element['image'],
            ));
      }
      _departments = loadedItems;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
