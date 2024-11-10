import 'package:get/get.dart';
import 'package:weatherly/core/models/cities_model.dart';
import 'package:weatherly/data/remote/api_checker.dart';
import 'package:weatherly/data/repositories/geonames_repository.dart';
import 'package:weatherly/core/controllers/weather_controller.dart';

class GeoNamesController extends GetxController {
  final GeoNamesRepository geoNamesRepository;
  final WeatherController weatherController = Get.find<WeatherController>();

  // Observable variables to manage state
  var isLoading = false.obs;
  var searchResults = <CitySearchResult>[].obs;
  var selectedCityName = ''.obs;

  GeoNamesController({required this.geoNamesRepository});

  // Function to search cities based on user input
  Future<void> searchCities(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;

    final response = await geoNamesRepository.searchCity(query);
    if (response.statusCode == 200 && response.body != null) {
      List<dynamic> citiesList = response.body;
      searchResults.value = citiesList
          .map((cityMap) => CitySearchResult.fromMap(cityMap))
          .toList();
    } else {
      ApiChecker.checkApi(response);
    }

    isLoading.value = false;
  }

  // Function to select a city and fetch weather data using coordinates
  void selectCity(CitySearchResult city) {
    selectedCityName.value = city.name;
    if (city.latitude != null && city.longitude != null) {
      weatherController.fetchWeatherForCity(city);
    }
  }
}
