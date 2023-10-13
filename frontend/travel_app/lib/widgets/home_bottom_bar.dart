import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  // final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: 2,
      animationDuration: const Duration(
        milliseconds: 300,
      ),
      backgroundColor: Colors.white70,
      color: Colors.transparent,
      items: const [
        Icon(
          Icons.person_outline,
          size: 30,
        ),
        Icon(
          Icons.favorite,
          size: 30,
        ),
        Icon(
          Icons.home,
          size: 30,
          color: Colors.redAccent,
        ),
        Icon(
          Icons.location_on_outlined,
          size: 30,
        ),
        Icon(
          Icons.list,
          size: 30,
        ),
      ],
    );
  }
}
