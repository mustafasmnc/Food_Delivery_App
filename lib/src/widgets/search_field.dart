import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          hintText: "Search Any Food",
          //labelText: "Search Any Food",
          suffixIcon: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              child: Icon(
                Icons.search,
                color: Colors.black,
              )),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
