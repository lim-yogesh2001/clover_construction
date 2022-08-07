import 'package:clover_construction/providers/auth.dart';
import 'package:clover_construction/providers/hireWorkers.dart';
import 'package:clover_construction/widgets/hired_worker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HiredWorkerScreen extends StatelessWidget {
  static const routeName = "hired-workers";
  const HiredWorkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).userInfo;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hired Workers",
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: const TextStyle(
            color: Colors.black87,
            fontFamily: "Lato-Bold",
            fontSize: 24.0,
            fontWeight: FontWeight.w700),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: FutureBuilder(
            future: Provider.of<HiredWorker>(context, listen: false)
                .fetchHiredWorkers(user['userId']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Consumer<HiredWorker>(
                  builder: (context, worker, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: worker.hiredWorkers.length,
                        itemBuilder: (ctx, index) {
                          return HiredWorkerItem(
                              hworker: worker.hiredWorkers[index]);
                        });
                  },
                );
              }
            }),
      )),
    );
  }
}
