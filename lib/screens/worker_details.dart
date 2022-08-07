import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/hireWorkers.dart';
import 'package:clover_construction/providers/auth.dart';
import 'package:clover_construction/providers/department.dart';
import 'package:clover_construction/providers/hireWorkers.dart';
import 'package:clover_construction/providers/worker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WorkerDetailScreen extends StatefulWidget {
  static const routeName = 'worker-details-screen';
  const WorkerDetailScreen({super.key});

  @override
  State<WorkerDetailScreen> createState() => _WorkerDetailScreenState();
}

class _WorkerDetailScreenState extends State<WorkerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final workerDetails =
        Provider.of<WorkerProvider>(context, listen: false).findById(id);
    final depData = Provider.of<DepartmentProvider>(context, listen: false)
        .findById(workerDetails.departmentId);
    final user = Provider.of<AuthProvider>(context, listen: false).userInfo;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image.network(
                    domain + workerDetails.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        )))
              ]),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "${workerDetails.experience} years of experience",
                style: const TextStyle(
                    color: textHighlighter,
                    fontFamily: 'Lato-Regular',
                    fontSize: 24.0),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                workerDetails.name,
                style: const TextStyle(
                    fontFamily: 'Lato-Bold',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    width: double.infinity,
                    height: 35,
                    color: Colors.grey,
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                      child: Text(
                        'Personal Information',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato-Bold',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address:  ${workerDetails.address}',
                            style: TextStyle(fontFamily: 'Lato'),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            'Address:  ${workerDetails.address}',
                            style: TextStyle(fontFamily: 'Lato'),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            "DOB:  " +
                                DateFormat.yMMMd().format(workerDetails.DOB),
                            style: TextStyle(fontFamily: 'Lato'),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            "Email:  ${workerDetails.email}",
                            style: TextStyle(fontFamily: 'Lato'),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text("Department:  ${depData.title}")
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    width: double.infinity,
                    height: 35,
                    color: Colors.grey,
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                      child: Text(
                        'Qualification',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato-Bold',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(workerDetails.qualification),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        minWidth: 120,
                        height: 45,
                        color: Colors.cyan,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Row(
                                      children: [
                                        SizedBox(
                                          height: 50.0,
                                          width: 50.0,
                                          child: Image.asset(
                                              'assets/images/correct.jpg'),
                                        ),
                                        const Text(
                                          "Confirm Hiring!",
                                          style: TextStyle(
                                              fontFamily: "Lato-Bold",
                                              fontSize: 18.0,
                                              color: textHighlighter),
                                        ),
                                      ],
                                    ),
                                    content: const Text(
                                      "Please Select Yes to Confirm the hiring!!!",
                                      style: TextStyle(
                                          fontFamily: "Lato-Light",
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        color: Colors.green,
                                        onPressed: () {
                                          Provider.of<HiredWorker>(context,
                                                  listen: false)
                                              .addWorkers(
                                                  user['userId'],
                                                  HirePostWorker(
                                                      0,
                                                      workerDetails.id,
                                                      DateTime.now(),
                                                      user['userId']))
                                              .then((_) =>
                                                  Navigator.of(context).pop());
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("Successfully Hired"))
                                          );
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      MaterialButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("No"),
                                      )
                                    ],
                                  ));
                        },
                        child: Text(
                          "Hire ${depData.title}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
