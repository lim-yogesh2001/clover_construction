import 'package:clover_construction/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final DateTime date;
  const CustomAppBar({required this.title, required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.0),
      height: 135,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              IconButton(onPressed: (){}, icon: Icon(Icons.person_pin_circle_rounded), iconSize: 34.0,)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
            height: 10.0,
          ),
          Text(DateFormat.yMMMMEEEEd().format(date), style: Theme.of(context).textTheme.bodyText1,)
            ],
          ),
        ],
      ),
    );
  }
}
