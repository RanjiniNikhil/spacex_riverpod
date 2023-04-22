import 'package:spacex_riverpod/models/rocket_response_model.dart';
import 'package:spacex_riverpod/retrofit/rest_client.dart';
import 'package:spacex_riverpod/retrofit/retrobase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RocketService {
  Future<List<RocketResponseModel>> getRocketInfo() async {
    return RestClient(RetroBase().dioData()).getRocketsInfo();
  }
}

final rocketProvider = Provider<RocketService>((ref) => RocketService());
