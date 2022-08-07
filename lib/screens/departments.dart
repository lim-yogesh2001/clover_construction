import 'package:clover_construction/providers/department.dart';
import 'package:clover_construction/providers/worker.dart';
import 'package:clover_construction/widgets/dep_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepartmentScreen extends StatelessWidget {
  static const routeName = 'department';
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: Provider.of<DepartmentProvider>(context, listen: false)
              .fetchDepartments(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<DepartmentProvider>(builder: (ctx, depData, child) {
                return GridView.builder(
                  itemCount: depData.departments.length,
                  shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.18
                    ),
                    itemBuilder: (ctxt, i) {
                      return DepartmentsItem(department: depData.departments[i]);
                    });
              });
            }
          }),
        ),
      ),
    ));
  }
}
