import 'dart:developer';

import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/models/destinations_model.dart';
import 'package:travel_app/widgets/post_appbar.dart';

class PostBottomBar extends StatelessWidget {
  const PostBottomBar({super.key, this.index, required this.destination});

  final int? index;

  final Destinations destination;

  @override
  Widget build(BuildContext context) {
    log('City: ${destination.cityName}');
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Color(0XFFEDF2F6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${destination.cityName}, ${destination.country}',
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 25,
                        color: Colors.amber,
                      ),
                      Text(
                        "${destination.rating ?? 0}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                destination.cityInfo,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageCarousel(
                                      destination: destination,
                                    )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          destination.cityImages[index!],
                          fit: BoxFit.cover,
                          height: 90,
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageCarousel(
                                    destination: destination,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          destination.cityImages[index! + 1],
                          fit: BoxFit.cover,
                          height: 90,
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageCarousel(
                                      destination: destination,
                                    )));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 90,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                                destination.cityImages[index! + 2]),
                            opacity: 0.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Text(
                          '${destination.cityImages.length - 1} +',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Attractions',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // width: 150,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: destination.attractions.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 200,
                            height: 40,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26),
                              ],
                            ),
                            child: Text(
                              destination.attractions[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 4)
                          ],
                        ),
                        child: const Icon(
                          Icons.bookmark_outline,
                          size: 40,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent,
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 4)
                            ],
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ]),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key, required this.destination});

  final Destinations destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: PostAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            FanCarouselImageSlider(
              imagesLink: destination.cityImages,
              isAssets: false,
              autoPlay: true,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewerPage extends StatelessWidget {
  const ImageViewerPage({super.key, required this.destination});

  final Destinations destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: PostAppBar(),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: destination.cityImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      opacity: 0.7,
                      image: NetworkImage(destination.cityImages[index]),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
