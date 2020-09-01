import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btnText;

  const Button({this.btnText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.blueAccent, borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Text(
          "$btnText",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
