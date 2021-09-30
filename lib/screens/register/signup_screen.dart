import 'package:flutter/material.dart';
import 'package:shopy/shared/componenst/components.dart';
import 'package:shopy/shared/componenst/validator.dart';
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
                      validator: (val)=> Validator.phoneValidator(val)
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
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
