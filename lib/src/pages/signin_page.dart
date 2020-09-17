import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:food_app/src/pages/signup_page.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/button.dart';
import 'package:food_app/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _toggleVisibility = true;
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String _password;
  String _email;

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign In",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
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
                _builtSignInButton(),
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
        ),
      ),
    );
  }

  Widget _builtSignInButton() {
    return ScopedModelDescendant(
      builder: (BuildContext sctx, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            showLoadingIndicator(context, "Signin In...");
            onSubmit(model.authendicate);
          },
          child: Button(btnText: "Sign In"),
        );
      },
    );
  }

  void onSubmit(Function authendicate) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      authendicate(_email, _password,null).then((final response) {
        if (!response['hasError']) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/mainscreen");
        } else {
          Navigator.of(context).pop();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
              content: Text(response['message']),
            ),
          );
        }
      });
    }
  }
}
