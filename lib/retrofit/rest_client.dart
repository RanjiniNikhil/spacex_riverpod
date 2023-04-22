import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:spacex_riverpod/models/rocket_response_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://api.spacexdata.com')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/v4/rockets')
  Future<List<RocketResponseModel>> getRocketsInfo();
}
