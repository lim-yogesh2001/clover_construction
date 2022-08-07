import 'package:clover_construction/providers/auth.dart';
import 'package:clover_construction/providers/worker.dart';
import 'package:clover_construction/widgets/worker_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrokerScreen extends StatelessWidget {
  static const routeName = 'worker-screen';
  const WrokerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dep =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final depId = dep['dep_id'];
    final depTitle = dep['dep_title'];
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(depTitle.toString(), style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: Provider.of<WorkerProvider>(context, listen: false).fetchWorkers(depId.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Consumer<WorkerProvider>(builder: (context, workerData, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: workerData.workers.length,
                    itemBuilder: (ctx, index) {
                    return WorkerItem(worker: workerData.workers[index]);
                  });
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
