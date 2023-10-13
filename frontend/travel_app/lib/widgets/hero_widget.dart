// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../services/services.dart';

// import '../main.dart';
// import '../models/destinations_model.dart';
// import '../models/user_model.dart';

// import '../widgets/post_screen.dart';

// class HeroWidget extends StatefulHookConsumerWidget {
//   const HeroWidget({super.key, this.destinations});

//   final List<Destinations>? destinations;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HeroWidgetState();
// }

// class _HeroWidgetState extends ConsumerState<HeroWidget> {
//   bool idExists = false;
//   Map<Destinations, bool> bookmarkChecks = {};

//   String? destId;

//   @override
//   void initState() {
//     super.initState();
//     checkId();
//   }

//   void checkId() {
//     var bookmarks = prefs!.getStringList('bookmarks');
//     if (bookmarks != null) {
//       for (final bookmarkId in bookmarks) {
//         final destination =
//             widget.destinations!.firstWhere((dest) => dest.id == bookmarkId);
//         bookmarkChecks[destination] = true;
//       }
//     }
//   }

//   Future<User> getBookMarks() async {
//     return await DestinationServices.bookmarkOrUnbookmarkDestination(destId!);
//   }

//   final _bookmarkStatusController = StreamController<bool>();

// // Stream to expose
//   Stream<bool> get bookmarkStatusStream => _bookmarkStatusController.stream;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: 200,
//             child: ListView.builder(
//               itemCount: widget.destinations!.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: ((context, index) {
//                 final isBookmarked =
//                     bookmarkChecks[widget.destinations![index]] ?? false;
//                 return InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PostScreen(
//                           destinations: widget.destinations![index],
//                           index: index,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     width: 160,
//                     padding: const EdgeInsets.all(20),
//                     margin: const EdgeInsets.only(left: 15),
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(15),
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         opacity: 0.7,
//                         image: NetworkImage(
//                             widget.destinations![index].cityImages.first),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         FutureBuilder(
//                             future: getBookMarks(),
//                             builder: (context, snapshot) {
//                               return Container(
//                                 alignment: Alignment.topRight,
//                                 child: IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       destId = widget.destinations![index].id;
//                                     });
//                                   },
//                                   icon: Icon(
//                                     isBookmarked
//                                         ? Icons.bookmarks_rounded
//                                         : Icons.bookmark_border_outlined,
//                                     color: isBookmarked
//                                         ? Colors.amber
//                                         : Colors.white,
//                                     size: 30,
//                                   ),
//                                 ),
//                               );
//                             }),
//                         const Spacer(),
//                         Container(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             widget.destinations![index].cityName,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/services.dart';

import '../main.dart';
import '../models/destinations_model.dart';
import '../models/user_model.dart';

import '../widgets/post_screen.dart';

class HeroWidget extends StatefulHookConsumerWidget {
  const HeroWidget({super.key, this.destinations});

  final List<Destinations>? destinations;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeroWidgetState();
}

class _HeroWidgetState extends ConsumerState<HeroWidget> {
  bool idExists = false;
  Map<Destinations, bool> bookmarkChecks = {};

  String? destId;

  @override
  void initState() {
    super.initState();
    checkId();
  }

  void checkId() {
    var bookmarks = prefs!.getStringList('bookmarks');
    if (bookmarks != null) {
      for (final bookmarkId in bookmarks) {
        final destination =
            widget.destinations!.firstWhere((dest) => dest.id == bookmarkId);
        bookmarkChecks[destination] = true;
      }
    }
  }

  final _bookmarkStatusController = StreamController<bool>();

// Stream to expose
  Stream<bool> get bookmarkStatusStream => _bookmarkStatusController.stream;

  @override
  void dispose() {
    _bookmarkStatusController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bookmarkStatusStream,
      builder: (context, snapshot) => Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: widget.destinations!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  final isBookmarked =
                      bookmarkChecks[widget.destinations![index]] ?? false;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostScreen(
                            destinations: widget.destinations![index],
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 160,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 0.7,
                          image: NetworkImage(
                              widget.destinations![index].cityImages.first),
                        ),
                      ),
                      child: Column(
                        children: [
                          // StreamBuilder(
                          //     stream: bookmarkStatusStream,
                          //     builder: (context, snapshot) {
                          //       return
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  destId = widget.destinations![index].id;
                                });
                              },
                              icon: Icon(
                                isBookmarked
                                    ? Icons.bookmarks_rounded
                                    : Icons.bookmark_border_outlined,
                                color:
                                    isBookmarked ? Colors.amber : Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          // }),
                          const Spacer(),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              widget.destinations![index].cityName,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
