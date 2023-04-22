import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_riverpod/models/rocket_response_model.dart';
import 'package:spacex_riverpod/services/rocket_service.dart';

final rocketDataProvider =
    FutureProvider<List<RocketResponseModel>>((ref) async {
  return ref.watch(rocketProvider).getRocketInfo();
});
