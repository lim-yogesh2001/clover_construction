import 'dart:convert';

import 'package:clover_construction/models/worker.dart';
import 'package:flutter/cupertino.dart';
import '../constants/static_urls.dart';
import 'package:http/http.dart' as http;

class WorkerProvider with ChangeNotifier {
  List<Worker> _workers = [];

  get workers {
    return [..._workers];
  }

  Worker findById(int id) {
    return _workers.firstWhere((value) => value.id == id);
  }

  Future<void> fetchWorkers(String depId) async {
    final url = workerList + depId;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        final List<Worker> loadedItems = [];
        if (extractedData.isEmpty) {
          return;
        }
        for (var value in extractedData) {
          loadedItems.insert(
              0,
              Worker(
                id: value['id'],
                name: value['name'],
                imageUrl: value['image'],
                address: value['address'],
                DOB: DateTime.parse(value['DOB']),
                email: value['email'],
                qualification: value['qualification'],
                experience: value['experience'],
                isFavorite: value['isFavorite'],
                departmentId: value['departments'],
              ));
        }
        _workers = loadedItems;
        print(loadedItems);
        notifyListeners();
      } else {
        throw Exception('Something Went Wrong');
      }
    } catch (error) {
      throw error;
    }
  }
}
