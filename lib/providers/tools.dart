import 'dart:convert';

import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/models/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

class StoreToolsProvider with ChangeNotifier {
  List<Tools> _tools = [];

  get tools {
    return [..._tools];
  }

  Tools findToolsById(int id){
    return _tools.firstWhere((tool) => tool.id == id);
  }

  Tools? findTools(int id){
    return _tools.firstWhereOrNull((element) => element.id == id);
  }

  int totalPrice(int quantity, int price){
    return quantity * price;
  }

  Future<void> fetchTools(String storeId, String categoryId) async {
    final url = "$productListApi$storeId/$categoryId";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        final List<Tools> loadedItem = [];
        if (extractedData.isEmpty == true) {
          return;
        }
        for (var element in extractedData) {
          loadedItem.insert(
            0,
            Tools(
                id: element['id'],
                title: element['title'],
                image: element['prod_image'],
                description: element['description'],
                brand: element['brand'],
                price: element['price'],
                category_id: element['category_id']),
          );
        }
        _tools = loadedItem;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }
}
