import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enjoy',
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 35,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'to the world!',
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 35,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
          style: TextStyle(
              color: Colors.black87.withOpacity(0.8),
              fontSize: 16,
              letterSpacing: 1.2),
        ),
      ],
    );
  }
}
