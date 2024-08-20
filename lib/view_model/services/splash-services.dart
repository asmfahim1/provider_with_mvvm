

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider_with_mvvm/model/user_model.dart';
import 'package:provider_with_mvvm/utils/routes/route_name.dart';
import 'package:provider_with_mvvm/view_model/user_view_model.dart';

class SplashServices {

  Future<LoginModel> getUserData() => UserViewModel().getUser();


  void checkAuthentication(BuildContext context) async{
    getUserData().then((value) async{
      await Future.delayed(const Duration(seconds: 3));

      if(value.token == 'null' || value.token == ''){
        if (kDebugMode) {
          print('Token is : ${value.token}');
        }

        if(!context.mounted) return;
        Navigator.pushNamed(context, RouteName.login);
      }else{

        if(!context.mounted) return;
        Navigator.pushNamed(context, RouteName.home);
      }
    }).onError((error, stackTrace){

      if (kDebugMode) {
        print('Error occurred \n$error');
      }

    });
  }




}