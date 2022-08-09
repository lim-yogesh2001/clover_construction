import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/store_category.dart';
import 'package:clover_construction/screens/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StoreCategoriesItem extends StatelessWidget {
  final int storeId;
  final StoreCategory sCategoryItem;
  const StoreCategoriesItem({required this.storeId,required this.sCategoryItem, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ToolsScreen.routeName, arguments: {"store_id": storeId, "category_id": sCategoryItem.id});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 2,
        child: Column(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Image.network(domain + sCategoryItem.categoryImage, fit: BoxFit.contain,),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(sCategoryItem.categoryName, style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),)
          ],
        ),
        ),
      ),
    );
  }
}