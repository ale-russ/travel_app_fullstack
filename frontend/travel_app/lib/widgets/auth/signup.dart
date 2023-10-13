import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screens/welcome.dart';
import 'package:travel_app/widgets/auth_form.dart';

import '../../services/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isVisible = true;
  String fullName = '';
  String email = '';
  String password = '';

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email address.';
    } else if (!EmailValidator.validate(email)) {
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    } else if (password.length < 6) {
      return 'Password should be at least 8 characters';
    } else {
      return null;
    }
  }

  String? validateName(String? name) {
    if (name == null) {
      return "Please enter a name";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  validator: validateName,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  controller: nameController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.person_2_outlined,
                    ),
                    label: const Text(
                      "full name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      fullName = nameController.text;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  validator: validateEmail,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  controller: emailController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    label: const Text(
                      "email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = emailController.text.trim();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  obscureText: isVisible,
                  controller: passwordController,
                  validator: validatePassword,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: isVisible
                            ? const Icon(Icons.lock_clock_outlined)
                            : const Icon(Icons.lock_open_outlined)),
                    label: const Text(
                      "password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = passwordController.text;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var messenger = ScaffoldMessenger.of(context);
                      if (_formKey.currentState!.validate()) {
                        final navigator = Navigator.of(context);
                        await DestinationServices.signUp(
                          fullName: nameController.text,
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        );
                        var message = DestinationServices.serverMessage;
                        log('ServerMessage: $message');
                        if (message == "Email already exists") {
                          messenger
                              .showSnackBar(SnackBar(content: Text(message!)));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130, 50),
                      elevation: 4,
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(
                            child: AuthForm(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130, 50),
                      elevation: 4,
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
