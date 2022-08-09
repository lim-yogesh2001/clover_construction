import 'package:clover_construction/providers/auth.dart';
import 'package:clover_construction/providers/orders.dart';
import 'package:clover_construction/providers/tools.dart';
import 'package:clover_construction/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "cart-screen";
  const OrdersScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final userData = Provider.of<AuthProvider>(context, listen: false).userInfo;
    final userId = userData['userId'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders",
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: const TextStyle(
            color: Colors.black87,
            fontFamily: "Lato-Bold",
            fontSize: 24.0,
            fontWeight: FontWeight.w700),
      ),
      body: SafeArea(
          child: FutureBuilder(
            future: Provider.of<OrderProvider>(context, listen: false)
                .fetchUserOrders(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Consumer<OrderProvider>(builder: (ctx, order, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: order.userOrders.length,
                      itemBuilder: (ct, i) {
                        return OrderItem(
                          orderData: order.userOrders[i],
                        );
                      });
                });
              }
            },
          )),
    );
  }
}
