// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/providers/network_provider.dart';
import 'package:shopy/screens/shop%20layout/shop_layout.dart';
import 'package:shopy/shared/componenst/components.dart';
import 'package:shopy/shared/netowrk/keys.dart';
import 'package:shopy/shared/netowrk/local/shared_helper.dart';
// import 'package:shopy/shared/componenst/validator.dart';
import '../register/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NetworkProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/images/login.png'),
                    ),
                    Text(
                      "Login",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.black),
                    ),
                    MyTextField(
                      controller: _email,
                      label: "Email",
                      hint: "Please enter your email",
                      icon: Icons.email,
                      //  validator: (val) => Validator.emailValidator(val)
                    ),
                    MyTextField(
                      controller: _password,
                      label: "Password",
                      hint: "Please enter your password",
                      isPassword: true,
                      icon: Icons.lock,
                      //  validator: (val) => Validator.passwordValidator(val),
                    ),
                    if (provider.loggedInStatus == Status.authenticating)
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print("click");
                              Provider.of<NetworkProvider>(context,
                                      listen: false)
                                  .userLogin(
                                email: _email.text,
                                password: _password.text,
                              )
                                  .then((value) {
                                print(provider.loggedInStatus);
                                if (provider.loggedInStatus ==
                                    Status.loggenIn) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(provider.loginData!.message),
                                          backgroundColor: Colors.green));

                                  print("success");

                                  SharedHelper.saveData(
                                          key: TOKEN,
                                          value:
                                              provider.loginData!.data!.token)
                                      .then((value) {
                                    
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const ShopLayout(),
                                      ),
                                    );
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(provider.loginData!.message),
                                    backgroundColor: Colors.red,
                                  ));
                                  print("not succsess");
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Lets Go!!",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignupScreen()));
                            },
                            child: const Text("Create account"))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Forget password ?"),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Reset password"))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
