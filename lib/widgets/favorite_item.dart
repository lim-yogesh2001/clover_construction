import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/models/worker.dart';
import 'package:flutter/material.dart';

class FavoriteItem extends StatelessWidget {
  final Worker worker;
  const FavoriteItem({required this.worker,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 10.0,
            backgroundImage: NetworkImage( domain + worker.imageUrl),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(worker.name),
              const SizedBox(
                height: 5.0,
              ),
              Text(worker.email),
              const SizedBox(
                height: 5.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}