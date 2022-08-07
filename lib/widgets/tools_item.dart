import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/tools.dart';
import 'package:clover_construction/screens/tools_details.dart';
import 'package:flutter/material.dart';

class ToolsItem extends StatelessWidget {
  final Tools storeTools;
  const ToolsItem({required this.storeTools, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ToolsDetailsScreen.routeName, arguments: storeTools.id),
        child: Card(
            color: Color(0xf1f1f1f1),
            elevation: 2,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: Image.network(
                      domain + storeTools.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeTools.title,
                      style: const TextStyle(
                          fontFamily: 'Lato-Bold',
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Brand: ${storeTools.brand}",
                      style: const TextStyle(
                          fontFamily: 'Lato-Regular',
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Price: ${storeTools.price}",
                      style: const TextStyle(
                          color: textHighlighter,
                          fontFamily: 'Lato-Regular',
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
