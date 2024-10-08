import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_with_mvvm/resources/components/round_button.dart';
import 'package:provider_with_mvvm/utils/general_utils.dart';
import 'package:provider_with_mvvm/utils/routes/route_name.dart';
import 'package:provider_with_mvvm/utils/validator.dart';
import 'package:provider_with_mvvm/view_model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    print('=======widget build : ');
    //Size size = MediaQuery.of(context).size;
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email/User ID',
                    hintStyle: TextStyle(color: Colors.grey),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email_outlined),
                    suffix: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  validator: Validator().nullFieldValidate,
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, passwordFocusNode);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: _obscurePassword,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.key_outlined),
                          suffix: InkWell(
                            onTap: () {
                              _obscurePassword.value = !_obscurePassword.value;
                            },
                            child: Icon(_obscurePassword.value == true
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        obscureText: _obscurePassword.value,
                        obscuringCharacter: '*',
                        validator: Validator().nullFieldValidate,
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                RoundButton(
                  title: 'Login',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      Map data = {
                        "email": emailController.text,
                        "password": passwordController.text
                      };
                      authViewModel.loginMethod(data, context);
                      print('Api call');
                    }
                  },
                  loading: authViewModel.isLoading,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signUp);
                  },
                  child: const Text(
                    "don't have an account? Sign Up",
                    style: TextStyle(fontSize: 15, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
