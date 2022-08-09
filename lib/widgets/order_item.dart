import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/orders.dart';
import 'package:clover_construction/models/tools.dart';
import 'package:clover_construction/providers/tools.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatefulWidget {
  final Order orderData;
  const OrderItem({required this.orderData, super.key});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expand = false;

  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage(domain + widget.orderData.productId.image),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderData.productId.title,
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontFamily: "Lato",
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Brand: ${widget.orderData.productId.brand}",
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Price: ${widget.orderData.productId.price}",
                      style: const TextStyle(
                        color: textHighlighter,
                        fontFamily: "Lato",
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _expand = !_expand;
                        print(_expand);
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down)),
              ],
            ),
            if (_expand == true)
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Order Date:  ${DateFormat('yyy MMMM dd').format(widget.orderData.date)}"),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text("Shipping Date:  ${DateFormat('y MMM, H:ss').format(widget.orderData.shippingTime)}"),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text("Quantity: ${widget.orderData.prodQuantity}"),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text("Total: ${widget.orderData.total}", style: TextStyle(color: Colors.red, ),)
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
