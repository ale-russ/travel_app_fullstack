import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_app/screens/welcome.dart';
import 'package:travel_app/services/services.dart';
import 'package:travel_app/widgets/auth_form.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                log('Button clicked');

                var navigator = Navigator.of(context);
                var isLoggedOut = await DestinationServices.logout();

                if (isLoggedOut) {
                  navigator.push(MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(
                            child: AuthForm(),
                          )));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.sort_rounded,
                  size: 28,
                ),
              ),
            ),
            // const Row(
            //   children: [
            //     Icon(
            //       Icons.location_on,
            //       color: Color(0XFFF65959),
            //     ),
            //     Text('London, UK')
            //   ],
            // ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.search,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
