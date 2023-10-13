import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/providers/destination_providers.dart';

import '../main.dart';
import '../widgets/home_appbar.dart';
import '../widgets/hero_widget.dart';
// import '../widgets/home_bottom_bar.dart';
import '../widgets/places_widget.dart';

class HomePage extends ConsumerWidget {
  HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var destinations = ref.watch(destinationsProvider);
    log("bookmarks: ${prefs!.getStringList('bookmarks')}");
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90), child: HomeAppBar()),
      body: destinations.when(
        data: (data) {
          log('Data: ${data.length}');
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeroWidget(destinations: data),
                    const SizedBox(height: 20),
                    PlacesWidget(destinations: data),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Error Please try again: $error'),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      // bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
