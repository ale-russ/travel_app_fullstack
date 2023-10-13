import 'package:flutter/material.dart';
import 'package:travel_app/controllers/auth_controller.dart';

import '../screens/home_page.dart';
import 'auth/signup.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.email,
    required this.password,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final navigator = Navigator.of(context);
                var response =
                    await AuthController().userlogin(email, password);

                if (response.token.isNotEmpty || response.token != null) {
                  navigator.push(MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(120, 50),
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
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
              "Register",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
