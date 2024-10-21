import 'package:get/get.dart';
import 'package:weatherly/core/utils/environment.dart';
import 'package:weatherly/data/remote/api_client.dart';

class WeatherRepository extends GetxService {
  final ApiClient apiClient;

  WeatherRepository({required this.apiClient});

  Future<Response> fetchWeather({
    required double lat,
    required double lon,
    String? exclude,
    String units = 'metric',
    String lang = 'en',
  }) async {
    final String apiKey = Environment.openWeatherApiKey;
    final String uri =
        '${Environment.openWeatherBaseUrl}${Environment.oneCallUrl}';
    final Map<String, String> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey,
      'units': units,
      'lang': lang,
      if (exclude != null) 'exclude': exclude,
    };
    return apiClient.getWithParamsData(uri, queryParams: queryParams);
  }

  Future<Response> fetchWeatherByTimestamp({
    required double lat,
    required double lon,
    required int timestamp,
    String units = 'metric',
    String lang = 'en',
  }) async {
    final String apiKey = Environment.openWeatherApiKey;
    final String uri = '${Environment.openWeatherBaseUrl}${Environment.timeMachineUrl}';
    final Map<String, String> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'dt': timestamp.toString(),
      'appid': apiKey,
      'units': units,
      'lang': lang,
    };
    return apiClient.getWithParamsData(uri, queryParams: queryParams);
  }
}
