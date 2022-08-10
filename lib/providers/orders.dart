import 'dart:convert';

import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/models/orders.dart';
import 'package:clover_construction/models/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<Order> _userOrders = [];
  final List<OrderPost> _orderPost = [];

  get userOrders {
    return [..._userOrders];
  }

  get orderPost {
    return _orderPost.lastWhere((element) => element.id == _orderPost.length - 1); 
  }

  Future<void> setUserOrder(int userId, DateTime date, int total,
      DateTime shipping_time, int prod_quantity, int prodId) async {
    final url = "$orderListUrl/$userId/";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          "id": 0,
          "date": date.toString(),
          "total": total,
          "shipping_time": shipping_time.toString(),
          "prod_quantity": prod_quantity,
          "products": prodId,
          "user": userId,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode >= 400) {
        return;
      }
      final newOrder = OrderPost(
        0,
        date,
        total,
        prod_quantity,
        shipping_time,
        prodId,
        userId,
      );
      _orderPost.add(newOrder);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchUserOrders(int userId) async {
    final url = "$orderListUrl/$userId";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        final List<Order> loadedItem = [];
        if (extractedData.isEmpty) {
          return;
        } else {
          for (var element in extractedData) {
            loadedItem.insert(
                0,
                Order(
                  element['id'],
                  DateTime.parse(element['date']),
                  element['total'],
                  element['prod_quantity'],
                  DateTime.parse(element['shipping_time']),
                  Tools(
                    id: element['products']['id'],
                    title: element['products']['title'],
                    image: element['products']['prod_image'],
                    description: element['products']['description'],
                    brand: element['products']['brand'],
                    price: element['products']['price'],
                    category_id: element['products']['category_id'],
                  ),
                ));
          }
          _userOrders = loadedItem;
          notifyListeners();
        }
      } else {
        throw Exception("Something Went Wrong");
      }
    } catch (error) {
      throw error;
    }
  }
}
