import 'dart:convert';

import 'package:food_app/src/enums/auth_mode.dart';
import 'package:food_app/src/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  List<User> _users = [];
  User _authenticatedUser;
  bool _isLoading = false;

  List<User> get users {
    return List.from(_users);
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<bool> addUserInfo(Map<String, dynamic> userInfo) async {
    _isLoading = true;
    notifyListeners();
    try {
      final http.Response response = await http.post(
          "https://fooddelivery-a03a8.firebaseio.com/users.json",
          body: json.encode(userInfo));

      final Map<String, dynamic> responseData = json.decode(response.body);

      User userWithID = User(
        id: responseData['name'],
        email: userInfo['email'],
        username: userInfo['username'],
      );

      _users.add(userWithID);
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<Map<String, dynamic>> authendicate(
      String email, String password, String username,
      {AuthMode authMode = AuthMode.SignIn}) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "resturnSecureToken": true,
    };

    Map<String, dynamic> userInfo = {
      "email": email,
      "username": username,
    };

    String message;
    bool hasError = false;
    try {
      http.Response response;
      if (authMode == AuthMode.SignUp) {
        response = await http.post(
            "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB3gJrjojf2MOyBsQtUJMkAPmSsn_imApE",
            body: json.encode(authData),
            headers: {'Content-Type': 'application/json'});

        addUserInfo(userInfo);
      } else if (authMode == AuthMode.SignIn) {
        response = await http.post(
            "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB3gJrjojf2MOyBsQtUJMkAPmSsn_imApE",
            body: json.encode(authData),
            headers: {'Content-Type': 'application/json'});
      }

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody.containsKey('idToken')) {
        _authenticatedUser = User(
          id: responseBody['localId'],
          email: responseBody['email'],
          token: responseBody['idToken'],
          usertype: 'customer',
        );
        message = authMode == AuthMode.SignUp
            ? "Succesfully Sign Up"
            : "Succesfully Sign In";
      } else {
        if (responseBody['error']['message'] == 'EMAIL_EXISTS') {
          message = "Email Already Exist";
        } else if (responseBody['error']['message'] ==
            'TOO_MANY_ATTEMPTS_TRY_LATER') {
          message = "Try It Later";
        } else if (responseBody['error']['message'] ==
            'WEAK_PASSWORD : Password should be at least 6 characters') {
          message = "The Password Must be 6 Characters Long or More";
        } else if (responseBody['error']['message'] == 'EMAIL_NOT_FOUND') {
          message = "Email Not Found";
        } else if (responseBody['error']['message'] == 'INVALID_PASSWORD') {
          message = "Password is Incorrect";
        } else if (responseBody['error']['message'] == 'USER_DISABLED') {
          message = "User Not Found";
        } else {
          message = authMode == AuthMode.SignUp
              ? "Failed to Signed Up"
              : "Failed to Signed In";
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
