import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_with_mvvm/resources/components/round_button.dart';
import 'package:provider_with_mvvm/utils/general_utils.dart';
import 'package:provider_with_mvvm/utils/routes/route_name.dart';
import 'package:provider_with_mvvm/utils/validator.dart';
import 'package:provider_with_mvvm/view_model/auth_view_model.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    print('=======widget build : ');
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign up'),
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
                  title: 'Sign up',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      Map data = {
                        "email": emailController.text,
                        "password": passwordController.text
                      };
                      authViewModel.signUpMethod(data, context);
                      print('Api call');
                    }
                  },
                  loading: authViewModel.signUpLoading,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.login);
                  },
                  child: const Text(
                    "already have an account? Login",
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
