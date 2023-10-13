import 'package:flutter/material.dart';

import 'post_appbar_tile.dart';

class PostAppBar extends StatelessWidget {
  const PostAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PostAppBarTile(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
                onTap: () => Navigator.pop(context)),
            PostAppBarTile(
              onTap: () {
                print('Button Pressed');
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.redAccent,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
