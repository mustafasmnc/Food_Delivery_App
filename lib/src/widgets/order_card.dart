import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 75,
              width: 45,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Color(0xFFD3D3D3),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Color(0xFFD3D3D3),
                      )),
                  Text(
                    "0",
                    style: TextStyle(fontSize: 16, color: Color(0xFFD3D3D3)),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFFD3D3D3),
                      )),
                ],
              ),
            ),
            SizedBox(width: 20),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/lunch.jpeg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(33),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0,
                      offset: Offset(5, 5),
                    )
                  ]),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Grilled Chicken",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text("3.0 \u20BA",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 16)),
                SizedBox(height: 4),
                Container(
                  height: 25,
                  width: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Text("Chicken",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {},
                              child: Text("x",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
            GestureDetector(
                onTap: () {}, 
                child: Icon(Icons.cancel, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
