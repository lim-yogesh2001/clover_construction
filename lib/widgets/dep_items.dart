import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/department.dart';
import 'package:clover_construction/screens/worker.dart';
import 'package:flutter/material.dart';

class DepartmentsItem extends StatelessWidget {
  final Department department;
  const DepartmentsItem({required this.department, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(WrokerScreen.routeName, arguments: {"dep_id": department.id, "dep_title": department.title});
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: cardBackground,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Image.network(
                domain + department.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              department.title,
              style: const TextStyle(
                fontFamily: 'Lato-Regular',
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
