// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/providers/network_provider.dart';
import 'package:shopy/screens/shop%20layout/shop_layout.dart';
import 'package:shopy/shared/componenst/components.dart';
import 'package:shopy/shared/componenst/validator.dart';
import 'package:shopy/shared/netowrk/constants.dart';
import 'package:shopy/shared/netowrk/keys.dart';
import 'package:shopy/shared/netowrk/local/shared_helper.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
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
                      width: 150,
                      height: 100,
                      child: Image.asset('assets/images/signup.png'),
                    ),
                    Text(
                      "Sign up",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.black),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MyTextField(
                              controller: _firstName,
                              label: "First Name",
                              hasIcon: false,
                              validator: (val) => Validator.nameValidator(val),
                            ),
                          ),
                        ),
                        Expanded(
                          child: MyTextField(
                            controller: _lastName,
                            label: "Last Name",
                            hasIcon: false,
                            validator: (val) => Validator.nameValidator(val),
                          ),
                        ),
                      ],
                    ),
                    MyTextField(
                      controller: _email,
                      label: "Email",
                      hint: "Please enter your email",
                      icon: Icons.email,
                      validator: (val) => Validator.emailValidator(val),
                    ),
                    MyTextField(
                        controller: _password,
                        label: "Password",
                        hint: "Please enter your password",
                        isPassword: true,
                        icon: Icons.lock,
                        validator: (val) => Validator.passwordValidator(val)),
                    MyTextField(
                        controller: _phone,
                        label: "Phone Number",
                        hint: "Enter your phone number",
                        icon: Icons.phone,
                        validator: (val) => Validator.phoneValidator(val)),
                    if (provider.signUpStatus == Status.registering)
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            var name = _firstName.text + " " + _lastName.text;
                           await Provider.of<NetworkProvider>(context, listen: false)
                                .userRegister(
                              name: name,
                              email: _email.text,
                              password: _password.text,
                              phone: _phone.text,
                            )
                                .then((value) {
                              print(provider.signUpStatus);
                              if (provider.signUpStatus == Status.regesterd) {
                                print("success");
                                SharedHelper.saveData(key: TOKEN, value: token)
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
                                  content: Text(provider.registerModel!.message!),
                                  backgroundColor: Colors.red,
                                ));
                                print("not succsess");
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginScreen()));
                            },
                            child: const Text("Log in"))
                      ],
                    )
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
