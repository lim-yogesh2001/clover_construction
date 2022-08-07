import 'dart:convert';

import 'package:clover_construction/constants/static_urls.dart';
import 'package:flutter/cupertino.dart';
import '../models/store.dart';
import 'package:http/http.dart' as http;

class Stores with ChangeNotifier {
  List<Store> _stores = [];

  get items {
    return [..._stores];
  }

  Store findByID(int id){
    return _stores.firstWhere((element) => element.id == id);
  }

  Future<void> fetchStores() async {
    const url = storeList;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        final List<Store> loadedItem = [];
        extractedData.forEach((element) {
          loadedItem.insert(
              0,
              Store(
                id: element['id'],
                imageUrl: element['cover_image'],
                title: element['title'],
                address: element['address'],
                contact: element['contact_no'],
                store_description: element['store_description'],
                is_recent: element['is_recent'],
              ));
        });
        _stores = loadedItem;
        notifyListeners();
      } else {
        throw Exception('Failed to load the data');
      }
    } catch (error) {
      throw error;
    }
  }

  List<Store> get reacentStores {
    return _stores.where((stores) => stores.is_recent == true).toList();
  }
}
