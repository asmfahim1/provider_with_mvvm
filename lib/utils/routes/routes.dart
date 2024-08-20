

import 'package:flutter/material.dart';
import 'package:provider_with_mvvm/utils/routes/route_name.dart';
import 'package:provider_with_mvvm/view/home_screen.dart';
import 'package:provider_with_mvvm/view/login_screen.dart';
import 'package:provider_with_mvvm/view/sign_up_screen.dart';
import 'package:provider_with_mvvm/view/splash_screen.dart';

class Routes {
  static
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      case RouteName.splash :
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());
      case RouteName.home :
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RouteName.login :
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());
      case RouteName.signUp :
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpScreen());
      default :
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No routes defines'),
            ),
          );
        });
    }
  }
}