import 'package:flutter/material.dart';

class HomeTopInfo extends StatelessWidget {
  final textStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("What would", style: textStyle),
              Text("you like to eat", style: textStyle),
            ],
          ),
          Icon(
            Icons.notifications_none,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
