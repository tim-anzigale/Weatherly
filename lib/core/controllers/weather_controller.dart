import 'package:get/get.dart';
import 'package:weatherly/data/remote/api_checker.dart';
import 'package:weatherly/data/repositories/weather_repository.dart';

class WeatherController extends GetxController {
  final WeatherRepository weatherRepository;

  var isLoading = false.obs;
  var weatherData = <String, dynamic>{}.obs;
  var errorMessage = ''.obs; // Added errorMessage variable

  WeatherController({required this.weatherRepository});

  /// Fetch weather data for a given latitude and longitude
  Future<void> fetchWeatherData(double lat, double lon) async {
    isLoading.value = true; // Start loading
    errorMessage.value = ''; // Clear previous error message
    try {
      final response = await weatherRepository.fetchWeather(lat: lat, lon: lon);
      if (response.statusCode == 200) {
        weatherData.value = response.body;
      } else {
        ApiChecker.checkApi(response); // Set the error message from ApiChecker
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e'; // Set error message for caught exceptions
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  /// Fetch weather data for a specific timestamp using Time Machine API
  Future<void> fetchWeatherByTimestamp(double lat, double lon, int timestamp) async {
    isLoading.value = true; // Start loading
    errorMessage.value = ''; // Clear previous error message
    try {
      final response = await weatherRepository.fetchWeatherByTimestamp(
          lat: lat, lon: lon, timestamp: timestamp);
      if (response.statusCode == 200) {
        weatherData.value = response.body;
      } else {
         ApiChecker.checkApi(response); // Set the error message from ApiChecker
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e'; // Set error message for caught exceptions
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
