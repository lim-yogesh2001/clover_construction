import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/orders.dart';
import 'package:clover_construction/models/tools.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class ProductPaymnetScreen extends StatelessWidget {
  static const routeName = 'product-payment';
  const ProductPaymnetScreen({Key? key}) : super(key: key);

  // PaymentConfig makePyamentConfig(Order config){
  //   return PaymentConfig(amount: config.total, productIdentity: config.id.toString(), productName: productName)
  // }

  @override
  Widget build(BuildContext context) {
    final objData = ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmation Screen", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
              child: Column(
                children: [
                  Text(
                    objData['tools'].toString(),
                    style: const TextStyle(
                        fontFamily: "Lato-Bold",
                        fontSize: 24.0,
                        color: textHighlighter,
                        fontWeight: FontWeight.w400),
                  ),
                  const Divider(
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 150.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    // child: Image.network(),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    " Price: ",
                    style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: Image.asset('assets/images/correct.jpg', fit: BoxFit.cover,),
                      ),
                      const Text("Your Order was placed succcessfully!")
                    ],
                  ),
                  const Center(
                      // child: KhaltiButton(config: config, onSuccess: onSuccess, onFailure: onFailure),
                      )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
