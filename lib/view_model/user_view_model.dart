

import 'package:flutter/foundation.dart';
import 'package:provider_with_mvvm/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {

  Future<bool> saveUser(LoginModel user) async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<LoginModel> getUser() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token').toString();
    notifyListeners();
    return LoginModel(
      token: token,
    );
  }

  Future<bool> clearSession() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }

}