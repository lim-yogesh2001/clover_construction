import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/orders.dart';
import 'package:clover_construction/providers/auth.dart';
import 'package:clover_construction/providers/orders.dart';
import 'package:clover_construction/providers/store_category.dart';
import 'package:clover_construction/providers/tools.dart';
import 'package:clover_construction/screens/product_payment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

class ToolsDetailsScreen extends StatefulWidget {
  static const routeName = 'tools-details';
  const ToolsDetailsScreen({super.key});

  @override
  State<ToolsDetailsScreen> createState() => _ToolsDetailsScreenState();
}

class _ToolsDetailsScreenState extends State<ToolsDetailsScreen> {
  var _quantity = 0;
  var _total = 0;
  var _isInit = false;
  var _isLoading = false;

  int getTotal(int qunatity, int price) {
    _total = qunatity * price;
    return _total;
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final user = Provider.of<AuthProvider>(context, listen: false).userInfo;
    final toolsData = Provider.of<StoreToolsProvider>(context, listen: false)
        .findToolsById(id);
    final total = Provider.of<StoreToolsProvider>(context)
        .totalPrice(toolsData.price, _quantity);
    final categoryData = Provider.of<StoreCategoryProvider>(context)
        .findById(toolsData.category_id);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image.network(
                    domain + toolsData.image,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back))
              ]),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toolsData.title,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Lato-Bold',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Brand: ${toolsData.brand}",
                      style: const TextStyle(
                          fontFamily: 'Lato-Regular', fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Rs. ${toolsData.price}",
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 197, 142, 60)),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Category: ${categoryData.categoryName}",
                      style:
                          TextStyle(fontFamily: 'Lato-Regular', fontSize: 16.0),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Container(
                      height: 130,
                      child: Text(
                        "Description:  \n${toolsData.description}",
                        style: TextStyle(
                            fontFamily: 'Lato-Regular', fontSize: 15.0),
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Row(
                      children: [
                        Text("Quantity: "),
                        const SizedBox(
                          width: 10.0,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                            icon: const Icon(Icons.add)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          color: secondaryColor,
                          child: Text(_quantity.toString()),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_quantity <= 0) {
                                _quantity = 0;
                                return;
                              }
                              _quantity--;
                            });
                          },
                          icon: const Icon(Icons.minimize),
                          alignment: Alignment.topCenter,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text("Total : "),
                        Container(
                          width: 50.0,
                          height: 30.0,
                          color: Colors.red.shade300,
                          child: Text(total.toString()),
                          alignment: Alignment.center,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 200,
                      child: _isLoading == true ? const CircularProgressIndicator() : MaterialButton(
                        color: Colors.cyan,
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          Provider.of<OrderProvider>(context, listen: false)
                              .setUserOrder(
                                  user['userId'],
                                  DateTime.now(),
                                  total,
                                  DateTime.now(),
                                  _quantity,
                                  toolsData.id)
                              .then((_) {
                            setState(() {
                              _isLoading = false;
                            });
                          }).then((_) {
                            Navigator.of(context).pushNamed(
                                ProductPaymnetScreen.routeName,
                                arguments: toolsData);
                          });
                        },
                        child: const Text(
                          "Buy",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Lato"),
                        ),
                      )),

                  // SizedBox(
                  //     width: 200,
                  //     child: KhaltiButton(config: PaymentConfig(amount: amount, productIdentity: productIdentity, productName: productName), onSuccess: onSuccess, onFailure: onFailure)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
