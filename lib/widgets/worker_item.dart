import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/worker.dart';
import 'package:clover_construction/screens/worker_details.dart';
import 'package:flutter/material.dart';

class WorkerItem extends StatelessWidget {
  final Worker worker;
  const WorkerItem({required this.worker, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(WorkerDetailScreen.routeName, arguments: worker.id),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.all(5.0),
                height: 110,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    domain + worker.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    worker.name,
                    style: const TextStyle(
                        fontFamily: 'Lato-Bold',
                        fontSize: 18.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "${worker.experience} years of experience",
                    style: const TextStyle(
                        color: textHighlighter,
                        fontFamily: 'Lato-Regular',
                        fontSize: 14.0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Address: ${worker.address}",
                    style: const TextStyle(
                        fontFamily: 'Lato-Regular', fontSize: 13.0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  FittedBox(
                    child: Text(
                      "Email: ${worker.email}",
                      style: const TextStyle(
                          fontFamily: 'Lato-Light',
                          fontSize: 13.0,
                          color: Colors.blue),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
