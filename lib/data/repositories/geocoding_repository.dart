import 'package:get/get.dart';
import 'package:weatherly/core/utils/environment.dart';
import 'package:weatherly/data/remote/api_client.dart';

class GeocodingRepository extends GetxService {
  final ApiClient apiClient;

  GeocodingRepository({required this.apiClient});

  Future<Response> getCoordinates(String cityName) async {
    final uri = '${Environment.openWeatherBaseUrl}${Environment.geocodingDirectUrl}';
    final queryParams = {
      'q': cityName,
      'limit': '1',
      'appid': Environment.openWeatherApiKey,
    };
    return apiClient.getWithParamsData(uri, queryParams: queryParams);
  }

  Future<Response> getCityName(double lat, double lon) async {
    final uri = '${Environment.openWeatherBaseUrl}${Environment.geocodingReverseUrl}';
    final queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'limit': '1',
      'appid': Environment.openWeatherApiKey,
    };
    return apiClient.getWithParamsData(uri, queryParams: queryParams);
  }
}
