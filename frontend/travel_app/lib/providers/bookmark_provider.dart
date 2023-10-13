import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../services/services.dart';

final bookmarkProvider =
    FutureProvider.family<User, String>((ref, destinationId) async {
  return await DestinationServices.bookmarkOrUnbookmarkDestination(
      destinationId);
});
