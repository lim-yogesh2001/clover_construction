import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/hireWorkers.dart';
import 'package:clover_construction/providers/hireWorkers.dart';
import 'package:clover_construction/providers/worker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HiredWorkerItem extends StatelessWidget {
  final HireGETWorker hworker;
  const HiredWorkerItem({required this.hworker, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 90.0,
              width: 90.0,
              child: Image.network(
                domain + hworker.worker.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hworker.worker.name,
                  style: const TextStyle(
                    color: Colors.cyan,
                      fontFamily: "Lato-Bold",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "email: ${hworker.worker.email}",
                  style: const TextStyle(
                      fontFamily: "Lato-Light",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300),
                ),
                 const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Date of hire: "+ DateFormat.yMMMd().format(hworker.dateOfHire),
                  style: const TextStyle(
                      fontFamily: "Lato-Light",
                      color: textHighlighter,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300),
                ),            
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "experience : ${hworker.worker.experience} years of exp",
                  style: const TextStyle(
                      fontFamily: "Lato-Light",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
