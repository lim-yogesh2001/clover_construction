import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/providers/store.dart';
import 'package:clover_construction/providers/store_category.dart';
import 'package:clover_construction/widgets/store_category_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreCategoryScreen extends StatelessWidget {
  static const routeName = "store-category";
  const StoreCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("hello");
    final id = ModalRoute.of(context)?.settings.arguments as int;
    final store_details =
        Provider.of<Stores>(context, listen: false).findByID(id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white.withOpacity(1),
        elevation: 1,
        title: Text(
          store_details.title,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Lato-Bold"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(
                domain + store_details.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                color: primaryColor,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        store_details.title,
                        style: TextStyle(
                          color: Colors.blue.shade300,
                          fontFamily: "Lato-Bold",
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on, size: 16,),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(store_details.address)
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.phone, size: 16,),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(store_details.contact)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            FutureBuilder(
                future:
                    Provider.of<StoreCategoryProvider>(context, listen: false)
                        .fetchStoreCategories(id.toString()),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.error != null) {
                      return Center(
                        child: Text("Something Went Wrong"),
                      );
                    } else {
                      return Consumer<StoreCategoryProvider>(
                        builder: ((context, storeCategories, child) =>
                            GridView.builder(
                                shrinkWrap: true,
                                itemCount: storeCategories.categories.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 5.0,
                                  childAspectRatio: 1.38,
                                ),
                                itemBuilder: (ctx, index) {
                                  return StoreCategoriesItem(
                                    storeId: id,
                                    sCategoryItem:
                                        storeCategories.categories[index],
                                  );
                                })),
                      );
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
