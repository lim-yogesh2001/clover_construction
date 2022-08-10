import 'dart:convert';

import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/models/store_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class StoreCategoryProvider with ChangeNotifier {
  List<StoreCategory> _storeCategories = [];

  get categories {
    return [..._storeCategories];
  }

  StoreCategory findById(int id){
    return _storeCategories.firstWhere((element) => element.id == id);
  }

  Future<void> fetchStoreCategories(String id) async {
    final url = "$storeCategoriesUrl/$id";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        final List<StoreCategory> loadedItems = [];
        for (var element in extractedData) {
          loadedItems.insert(
            0,
            StoreCategory(
                id: element['id'],
                categoryImage: element['category_image'],
                categoryName: element['category_name']),
          );
        }
        _storeCategories = loadedItems;
        notifyListeners();
      } else {
        throw Exception("Something Went Wrong");
      }
    } catch (error) {
      throw error;
    }
  }
}
