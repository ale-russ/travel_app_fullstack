import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/models/destinations_model.dart';
import 'package:travel_app/services/services.dart';

final destinationsProvider = FutureProvider<List<Destinations>>((ref) async {
  return await DestinationServices.fetchDestinations();
});

final destinationIdProvider = StateProvider((ref) => '');

final bookmarkProvider = FutureProvider((ref) async {
  String? destinationId;
  final user =
      DestinationServices.bookmarkOrUnbookmarkDestination(destinationId!);

  return user;
});
