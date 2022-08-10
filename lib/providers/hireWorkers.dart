import 'dart:convert';

import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/models/hireWorkers.dart';
import 'package:clover_construction/models/worker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HiredWorker with ChangeNotifier {
  List<HireGETWorker> _hiredWorkers = [];
  final List<HirePostWorker> _hiredPostWorkers = [];

  get hiredWorkers {
    return [..._hiredWorkers];
  }

  Future<void> fetchHiredWorkers(int userId) async {
    final url = "$hireList/$userId/";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        final List<HireGETWorker> loadedWorkers = [];
        if (extractedData.isEmpty) {
          print("Empty");
          return;
        } else {
          extractedData.forEach((element) {
            loadedWorkers.insert(
              0,
              HireGETWorker(
                element['id'],
                Worker(
                    id: element['worker']['id'],
                    name: element['worker']['name'],
                    imageUrl: element['worker']['image'],
                    address: element['worker']['address'],
                    DOB: DateTime.parse(element['worker']['DOB']),
                    email: element['worker']['email'],
                    qualification: element['worker']['qualification'],
                    experience: element['worker']['experience'],
                    isFavorite: element['worker']['isFavorite'],
                    departmentId: element['worker']['departments']),
                DateTime.parse(element['date_of_hire']),
              ),
            );
          });
          print(loadedWorkers);
          _hiredWorkers = loadedWorkers;
          notifyListeners();
        }
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> addWorkers(int userId, HirePostWorker hworker) async {
    final url = "$hireList/$userId/";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          "id": hworker.id,
          "worker": hworker.worker,
          "date_of_hire": hworker.dateOfHire.toString(),
          "user_id": userId
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );
      var responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode >= 400) {
        return;
      } else {
        final loadedItem = HirePostWorker(
          hworker.id,
          hworker.worker,
          hworker.dateOfHire,
          userId,
        );
        _hiredPostWorkers.add(loadedItem);
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }
}
