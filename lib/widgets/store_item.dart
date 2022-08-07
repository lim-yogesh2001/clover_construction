import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/screens/store_category.dart';
import 'package:flutter/material.dart';

class StoreItem extends StatelessWidget {
  final int id;
  final String title;
  final String address;
  final String contact;
  final String image;

  const StoreItem(
      {required this.id,
      required this.title,
      required this.address,
      required this.contact,
      required this.image,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(StoreCategoryScreen.routeName, arguments: id);
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 90,
            child: ListTile(
              leading: SizedBox(
                height: 100,
                width: 120,
                child: Image.network(
                  domain + image,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text("Location: $address", style: TextStyle(
                    color: textHighlighter
                  ),),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Contact no: $contact")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
