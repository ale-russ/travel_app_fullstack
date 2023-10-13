import 'package:flutter/material.dart';

class PostAppBarTile extends StatelessWidget {
  const PostAppBarTile({super.key, required this.icon, required this.onTap});

  final Widget icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 6),
          ],
        ),
        child: icon,
      ),
    );
  }
}
