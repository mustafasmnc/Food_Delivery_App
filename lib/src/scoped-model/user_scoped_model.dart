import 'dart:convert';

import 'package:food_app/src/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  User _authenticatedUser;

  void authendicate(String email, String password) async {
    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "resturnSecureToken": true,
    };
    try {
      http.Response response = await http.post(
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB3gJrjojf2MOyBsQtUJMkAPmSsn_imApE",
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
      print("Signin up response: ${response.body}");
    } catch (error) {
      print("Signin up error: $error");
    }
  }
}
