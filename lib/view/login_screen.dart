import 'package:flutter/material.dart';
import 'package:provider_with_mvvm/utils/general_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Enter Email/User ID',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email_outlined),
                ),
                onFieldSubmitted: (value){
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.key_outlined),
                  suffix: InkWell(
                    onTap: () {},
                    child: Icon(Icons.visibility),
                  ),
                ),
                obscureText: true,
                obscuringCharacter: '*',
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  //authProvider.login();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red, borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.center,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
