import 'dart:convert';

import 'package:clover_construction/constants/static_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/order_transx.dart';

class TransectionProvider with ChangeNotifier {
  List<OrderTransection> _otranx = [];

  Future<void> setOrderTransection(OrderTransection ordtrans) async {
    const url = orderTranscetionUrl;
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "id": ordtrans.id,
            "transection_code": ordtrans.transectionCode,
            "status": ordtrans.status
          }));
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode >= 400) {
        print("Something Went Wrong");
        return;
      }
      final newOrderTransection = OrderTransection(
        ordtrans.id,
        ordtrans.transectionCode,
        ordtrans.status,
      );
      _otranx.add(newOrderTransection);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
