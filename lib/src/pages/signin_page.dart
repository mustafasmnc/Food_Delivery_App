import 'package:flutter/material.dart';
import 'package:food_app/src/pages/signup_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _toggleVisibility = true;

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        /*hintText: "Your Email or Username",
        hintStyle: TextStyle(
          color:Color(0xFFBDC2CB),
          fontSize: 18,
        ),*/
        labelText: "Your Email or Username",
        labelStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          /*hintText: "Password",
        hintStyle: TextStyle(
          color:Color(0xFFBDC2CB),
          fontSize: 18,
        ),*/
          labelText: "Password",
          labelStyle: TextStyle(
            color: Color(0xFFBDC2CB),
            fontSize: 18,
          ),
          suffixIcon: IconButton(
              icon: _toggleVisibility
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  _toggleVisibility = !_toggleVisibility;
                });
              })),
      obscureText: _toggleVisibility,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign In",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Forgotten Password?",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildEmailTextField(),
                    SizedBox(height: 10),
                    _buildPasswordTextField(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't Have an Account?",
                    style: TextStyle(
                        color: Color(0xFFBDC2CB),
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SignUpPage()));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
