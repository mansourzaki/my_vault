import 'package:flutter/material.dart';

import '../helpers/local_auth_helper.dart';


class AuthProvider with ChangeNotifier {
  bool isAuthenticated = false;

  authinticate() async {
    final result = await LocalAuthApi.authenticate();
    isAuthenticated = result;
    notifyListeners();
  }
}
