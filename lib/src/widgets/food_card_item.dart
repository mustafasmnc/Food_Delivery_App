import 'package:flutter/material.dart';
import 'package:food_app/src/widgets/small_button.dart';

class FoodItemCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;

  FoodItemCard(this.title, this.description, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 3),
                      color: Colors.black12,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/breakfast.jpeg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$title",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 260,
                        child: Text("$description"),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 260,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$price \u20BA",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SmallButton(
                              btnText: "Buy",
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
  }
}