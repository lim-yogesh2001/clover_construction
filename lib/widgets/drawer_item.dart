import 'dart:ffi';

import "package:flutter/material.dart";

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback function;
  const DrawerItem(
      {required this.icon,
      required this.title,
      required this.function,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: const TextStyle(
                fontFamily: 'Lato-Regular', fontWeight: FontWeight.normal),
          ),
          onTap: function,
        ),
        Divider(
          color: Colors.grey.shade400,
        )
      ],
    );
  }
}
