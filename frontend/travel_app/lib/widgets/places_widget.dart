import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/destinations_model.dart';
import 'post_screen.dart';

class PlacesWidget extends StatelessWidget {
  const PlacesWidget({
    super.key,
    this.destinations,
  });

  final List<Destinations>? destinations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8),
        //     child: Row(
        //       children: [
        //         for (int i = 0; i < categories.length; i++)
        //           Container(
        //             margin: const EdgeInsets.symmetric(horizontal: 10),
        //             padding: const EdgeInsets.all(8),
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(10),
        //               boxShadow: const [
        //                 BoxShadow(
        //                   color: Colors.black26,
        //                   blurRadius: 4,
        //                 )
        //               ],
        //             ),
        //             child: Text(
        //               categories[i],
        //               style: const TextStyle(
        //                   fontSize: 16, fontWeight: FontWeight.w500),
        //             ),
        //           )
        //       ],
        //     ),
        //   ),
        // ),
        const SizedBox(height: 10),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: destinations!.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostScreen(
                                    destinations: destinations![index],
                                    index: index,
                                  )));
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 0.7,
                          image: NetworkImage(
                              destinations![index].cityImages.first),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${destinations![index].cityName}, ${destinations![index].country}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.more_vert,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.amber,
                      ),
                      Text(
                        '${destinations![index].rating}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
