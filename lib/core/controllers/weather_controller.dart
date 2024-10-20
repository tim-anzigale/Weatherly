import 'package:get/get.dart';
import 'package:weatherly/data/remote/api_checker.dart';
import 'package:weatherly/data/repositories/weather_repository.dart';


class WeatherController extends GetxController {
  final WeatherRepository weatherRepository;

  var isLoading = false.obs;
  var weatherData = <String, dynamic>{}.obs;

  WeatherController({required this.weatherRepository});

  /// Fetch weather data for a given latitude and longitude
  Future<void> fetchWeatherData(double lat, double lon) async {
    isLoading.value = true; // Start loading
    try {
      final response = await weatherRepository.fetchWeather(lat: lat, lon: lon);
      if (response.statusCode == 200) {
        weatherData.value = response.body;
      } else {
        ApiChecker.checkApi(response); // Use ApiChecker to handle response
      }
    } catch (e) {
      // Optionally handle the error here if needed for logging or analytics
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  /// Fetch weather data for a specific timestamp using Time Machine API
  Future<void> fetchWeatherByTimestamp(double lat, double lon, int timestamp) async {
    isLoading.value = true; // Start loading
    try {
      final response = await weatherRepository.fetchWeatherByTimestamp(
          lat: lat, lon: lon, timestamp: timestamp);
      if (response.statusCode == 200) {
        weatherData.value = response.body;
      } else {
        ApiChecker.checkApi(response); // Use ApiChecker to handle response
      }
    } catch (e) {
      // Optionally handle the error here if needed for logging or analytics
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
