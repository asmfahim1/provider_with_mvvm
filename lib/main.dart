import 'package:flutter/material.dart';
import 'package:provider_with_mvvm/utils/routes/route_name.dart';
import 'package:provider_with_mvvm/utils/routes/routes.dart';
import 'package:provider_with_mvvm/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfffffdfa),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.yellow,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.green,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      //home: LoginScreen(),
      initialRoute: RouteName.login,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
