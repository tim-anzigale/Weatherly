import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/core/controllers/geocoding_controller.dart';
import 'package:weatherly/core/models/cities_model.dart';
import 'package:weatherly/core/services/geolocator_service.dart';
import 'package:weatherly/data/remote/api_checker.dart';
import 'package:weatherly/data/repositories/weather_repository.dart';

class WeatherController extends GetxController {
  final WeatherRepository weatherRepository;

  var isLoading = false.obs;
  var weatherData = <String, dynamic>{}.obs;
  var errorMessage = ''.obs;
  var selectedCityName = ''.obs;

  WeatherController({required this.weatherRepository});

  /// Fetch weather data for a given latitude and longitude
  Future<void> fetchWeatherData(double lat, double lon) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await weatherRepository.fetchWeather(lat: lat, lon: lon);
      if (response.statusCode == 200) {
        weatherData.value = response.body;
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch weather data based on the selected city
  Future<void> fetchWeatherForCity(CitySearchResult city) async {
    if (city.latitude != null && city.longitude != null) {
      selectedCityName.value = city.name;
      await fetchWeatherData(city.latitude!, city.longitude!);
    } else {
      errorMessage.value = 'Invalid city coordinates.';
    }
  }

  /// Fetch weather data using user's current location
  Future<void> fetchWeatherForCurrentLocation() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      Position position = await getCurrentLocation();
      double lat = position.latitude;
      double lon = position.longitude;

      await fetchCityName(lat, lon);
      await fetchWeatherData(lat, lon);
    } catch (e) {
      errorMessage.value = 'Error fetching location weather: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch city name using coordinates
  Future<void> fetchCityName(double lat, double lon) async {
    await Get.find<GeocodingController>().fetchCityName(lat, lon);
    selectedCityName.value = Get.find<GeocodingController>().cityName.value;
  }
}
