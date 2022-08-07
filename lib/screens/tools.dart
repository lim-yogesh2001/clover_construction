import 'package:clover_construction/providers/tools.dart';
import 'package:clover_construction/widgets/tools_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToolsScreen extends StatelessWidget {
  static const routeName = 'store-tools';
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final storeId = args['store_id'];
    final categoryId = args['category_id'];
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        title: Text("Tools Screen", style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: Provider.of<StoreToolsProvider>(context, listen: false).fetchTools(
              storeId.toString(),
              categoryId.toString(),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something Went Wrong"),
                  );
                } else {
                  return Consumer<StoreToolsProvider>(
                    builder: (ctx, storeTools, child) {
                      return ListView.builder(
                        itemCount: storeTools.tools.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return ToolsItem(
                                storeTools: storeTools.tools[index]);
                          });
                    },
                  );
                }
              }
            }),
      ),
    );
  }
}
