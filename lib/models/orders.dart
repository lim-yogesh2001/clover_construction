import 'package:clover_construction/models/tools.dart';

class Order {
  final int id;
  final DateTime date;
  final int total;
  final int prodQuantity;
  final DateTime shippingTime;
  final Tools productId;

  Order(
    this.id,
    this.date,
    this.total,
    this.prodQuantity,
    this.shippingTime,
    this.productId,
  );
}

class OrderPost {
  final int id;
  final DateTime date;
  final int total;
  final int prodQuantity;
  final DateTime shippingTime;
  final int productId;
  final int userId;

  OrderPost(
    this.id,
    this.date,
    this.total,
    this.prodQuantity,
    this.shippingTime,
    this.productId,
    this.userId,
  );
}
