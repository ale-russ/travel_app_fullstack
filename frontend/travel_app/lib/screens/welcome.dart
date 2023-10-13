import 'package:flutter/material.dart';
import '../widgets/intro_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage(
              'assets/image1.jpeg',
            ),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 65),
                  const IntroWidget(),
                  const SizedBox(height: 32),
                  child
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
