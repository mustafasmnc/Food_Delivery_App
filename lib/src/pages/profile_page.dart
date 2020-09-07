import 'package:flutter/material.dart';
import 'package:food_app/src/widgets/custom_list_tile.dart';
import 'package:food_app/src/widgets/small_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnNotification = false;
  bool turnOnLocation = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            offset: Offset(0, 4),
                            color: Colors.black38),
                      ],
                      image: DecorationImage(
                        image: AssetImage("assets/images/breakfast.jpeg"),
                        fit: BoxFit.cover,
                      )),
                  //child: Image.asset("assets/images/breakfast.jpeg",fit: BoxFit.cover,),
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Joe Doe",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "+905311111111",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    SmallButton(btnText: "Edit"),
                  ],
                )
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    CustomListTile(icon: Icons.location_on, text: "Location"),
                    Divider(height: 10, color: Colors.grey),
                    CustomListTile(
                        icon: Icons.visibility, text: "Change Password"),
                    Divider(height: 10, color: Colors.grey),
                    CustomListTile(icon: Icons.shopping_cart, text: "Shipping"),
                    Divider(height: 10, color: Colors.grey),
                    CustomListTile(icon: Icons.payment, text: "Payment"),
                    Divider(height: 10, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Notifications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "App Notification",
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                            value: turnOnNotification,
                            onChanged: (bool value) {
                              //print("The Value:$value");
                              setState(() {
                                turnOnNotification = value;
                              });
                            })
                      ],
                    ),
                    Divider(height: 10, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location Tracking",
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                            value: turnOnLocation,
                            onChanged: (bool value) {
                              //print("The Value:$value");
                              setState(() {
                                turnOnLocation = value;
                              });
                            })
                      ],
                    ),
                    Divider(height: 10, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Other",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Language", style: TextStyle(fontSize: 16)),
                      Divider(height: 30, color: Colors.grey),
                      Text("Currency", style: TextStyle(fontSize: 16)),
                      Divider(height: 30, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
