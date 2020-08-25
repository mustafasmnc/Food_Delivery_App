import 'package:flutter/material.dart';
import 'package:food_app/src/pages/signin_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _toggleVisibility = true;
  bool _toggleConfirmVisibility = true;

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        /*hintText: "Your Email or Username",
        hintStyle: TextStyle(
          color:Color(0xFFBDC2CB),
          fontSize: 18,
        ),*/
        labelText: "Email",
        labelStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        /*hintText: "Your Email or Username",
        hintStyle: TextStyle(
          color:Color(0xFFBDC2CB),
          fontSize: 18,
        ),*/
        labelText: "Username",
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

  Widget _buildConfirmPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          /*hintText: "Password",
        hintStyle: TextStyle(
          color:Color(0xFFBDC2CB),
          fontSize: 18,
        ),*/
          labelText: "Confirm Password",
          labelStyle: TextStyle(
            color: Color(0xFFBDC2CB),
            fontSize: 18,
          ),
          suffixIcon: IconButton(
              icon: _toggleConfirmVisibility
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  _toggleConfirmVisibility = !_toggleConfirmVisibility;
                });
              })),
      obscureText: _toggleConfirmVisibility,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign Up",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildUsernameTextField(),
                    SizedBox(height: 10),
                    _buildEmailTextField(),
                    SizedBox(height: 10),
                    _buildPasswordTextField(),
                    SizedBox(height: 10),
                    _buildConfirmPasswordTextField()
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
                  "Sign Up",
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
                Text("Already Have an Account?",
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
                        builder: (BuildContext context) => SignInPage()));
                  },
                  child: Text(
                    "Sign In",
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
