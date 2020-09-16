import 'dart:convert';

import 'package:food_app/src/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  User _authenticatedUser;
  bool _isLoading = false;

  User get authenticatedUser {
    return _authenticatedUser;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<Map<String, dynamic>> authendicate(
      String email, String password) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "resturnSecureToken": true,
    };
    String message;
    bool hasError = false;
    try {
      http.Response response = await http.post(
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB3gJrjojf2MOyBsQtUJMkAPmSsn_imApE",
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody.containsKey('idToken')) {
        _authenticatedUser = User(
          id: responseBody['localId'],
          email: responseBody['email'],
          token: responseBody['idToken'],
          usertype: 'customer',
        );
        message = "Succesfully Sign Up";
      } else {
        if (responseBody['error']['message'] == 'EMAIL_EXISTS') {
          message = "Email Already Exist";
        } else if (responseBody['error']['message'] ==
            'TOO_MANY_ATTEMPTS_TRY_LATER') {
          message = "Try It Later";
        } else if (responseBody['error']['message'] ==
            'WEAK_PASSWORD : Password should be at least 6 characters') {
          message = "The Password Must be 6 Characters Long or More";
        } else {
          message = "Failed to Signed Up";
        }
        hasError = true;
      }

      _isLoading = false;
      notifyListeners();
      return {
        'message': message,
        'hasError': hasError,
      };
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {
        'message': "Failed to Signed Up",
        'hasError': hasError,
      };
    }
  }
}
