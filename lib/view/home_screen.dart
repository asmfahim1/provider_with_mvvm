import 'package:flutter/material.dart';
import 'package:provider_with_mvvm/utils/routes/route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.login);
          },
          child: Text('Login screen'),
        ),
      ),
    );
  }
}
