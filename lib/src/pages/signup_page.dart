import 'package:flutter/material.dart';
import 'package:food_app/src/pages/signin_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _toggleVisibility = true;
  //bool _toggleConfirmVisibility = true;

  String _email;
  String _username;
  String _password;
  //String _confirmPassword;

  GlobalKey<FormState> _formKey = GlobalKey();

  Widget _buildEmailTextField() {
    return TextFormField(
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
      onSaved: (String email) {
        _email = email.trim();
      },
      validator: (String email) {
        email = email.trim();
        String errorMessage;
        final bool isValid = EmailValidator.validate(email);
        if (email.isEmpty) {
          errorMessage = "Email is required";
        }
        if (!isValid) {
          errorMessage = "Email is not valid";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildUsernameTextField() {
    return TextFormField(
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
      onSaved: (String username) {
        _username = username.trim();
      },
      validator: (String username) {
        username = username.trim();
        String errorMessage;
        if (username.isEmpty) {
          errorMessage = "Username is required";
        }
        if (username.length > 15) {
          errorMessage = "Username must less than 15 characters";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
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
      onSaved: (String password) {
        _password = password;
      },
      validator: (String password) {
        String errorMessage;
        if (password.isEmpty) {
          errorMessage = "Password is required";
        }
        return errorMessage;
      },
    );
  }

  // Widget _buildConfirmPasswordTextField() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         border: UnderlineInputBorder(),
  //         /*hintText: "Password",
  //       hintStyle: TextStyle(
  //         color:Color(0xFFBDC2CB),
  //         fontSize: 18,
  //       ),*/
  //         labelText: "Confirm Password",
  //         labelStyle: TextStyle(
  //           color: Color(0xFFBDC2CB),
  //           fontSize: 18,
  //         ),
  //         suffixIcon: IconButton(
  //             icon: _toggleConfirmVisibility
  //                 ? Icon(Icons.visibility_off)
  //                 : Icon(Icons.visibility),
  //             onPressed: () {
  //               setState(() {
  //                 _toggleConfirmVisibility = !_toggleConfirmVisibility;
  //               });
  //             })),
  //     obscureText: _toggleConfirmVisibility,
  //     onSaved: (String value) {},
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign Up",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
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
                        /*SizedBox(height: 10),
                        _buildConfirmPasswordTextField()*/
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildSignUpButton(),
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
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ScopedModelDescendant(
        builder: (BuildContext sctx, Widget child, MainModel model) {
      return GestureDetector(
        onTap: () {
          showLoadingIndicator(context, "Signing Up...");
          onSubmit(model.authendicate);
        },
        child: Container(
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
      );
    });
  }

  void onSubmit(Function authenticate) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("The mail: $_email, the password: $_password");
      authenticate(_email, _password).then((final response) {
        Navigator.of(context).pop();
        if (response['hasError']) {
          //Navigate to home page
        } else {
          //display the error message in the snackbar
        }
      });
    }
  }
}
