import 'package:flutter/material.dart';
import 'package:travel_app/models/destinations_model.dart';

import 'post_appbar.dart';
import 'post_bottombar.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key, required this.index, required this.destinations})
      : super(key: key);
  final int? index;
  final Destinations destinations;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            // image: AssetImage('assets/city${index! + 1}.jpg'),
            image: NetworkImage(destinations.cityImages.first)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: PostAppBar(),
        ),
        bottomNavigationBar: PostBottomBar(
          index: index,
          destination: destinations,
        ),
      ),
    );
  }
}
