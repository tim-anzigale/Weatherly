import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/core/base_widgets/custom_search_bar.dart';
import 'package:weatherly/core/controllers/geocoding_controller.dart';
import 'package:weatherly/core/controllers/geonames_controller.dart';
import 'package:weatherly/core/controllers/weather_controller.dart';
import 'package:weatherly/core/models/cities_model.dart';
import 'package:weatherly/core/services/geolocator_service.dart';
import 'package:weatherly/features/home/view/widgets/current_weather_display.dart';
import 'package:weatherly/features/home/view/widgets/daily_forecast.dart';
import 'package:weatherly/features/home/view/widgets/hourly_forecast.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherController weatherController = Get.find<WeatherController>();
  final GeocodingController geocodingController = Get.find<GeocodingController>();
  final GeoNamesController geoNamesController = Get.find<GeoNamesController>();

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWeather(); // Load weather on initialization
    print(':::::::::::::::::::::::::::::::::WeatherScreen initialized');
  }

  Future<void> _loadWeather() async {
    try {
      double? latitude;
      double? longitude;

      // Check if a city has been selected from the search
      String selectedCity = geoNamesController.selectedCityName.value;
      if (selectedCity.isNotEmpty) {
        await geocodingController.fetchCoordinates(selectedCity);
        latitude = geocodingController.coordinates['lat'];
        longitude = geocodingController.coordinates['lon'];
      } else {
        // Fallback to current location if no city is selected
        Position position = await getCurrentLocation();
        latitude = position.latitude;
        longitude = position.longitude;
        geoNamesController.selectCity('Current Location'); // Update selected city
      }

      await weatherController.fetchWeatherData(latitude!, longitude!);

      // Fetch city name if selected city is empty
      if (selectedCity.isEmpty) {
        await geocodingController.fetchCityName(latitude, longitude);
      }
    } catch (e) {
      weatherController.errorMessage.value = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(() => CustomSearchBar(
                  controller: searchController,
                  onChanged: (String query) {
                    geoNamesController.searchCities(query); // Update search results
                  },
                  onClear: () => searchController.clear(),
                  hintText: 'Search for cities...',
                  searchResults: geoNamesController.searchResults
                      .map<String>((result) => result['name'] as String)
                      .toList(),
                  onResultSelected: (String city) {
                    // Get the selected city details from search results
                    final selectedCity = geoNamesController.searchResults.firstWhere((result) => result['name'] == city);
                    final citySearchResult = CitySearchResult.fromMap(selectedCity);

                    geoNamesController.selectCity(city);
                    weatherController.fetchWeatherForCity(citySearchResult); // Fetch weather for the selected city
                    searchController.clear(); // Clear the input after selection
                  },
                )),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () => _loadWeather(), // Refresh weather based on location
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (weatherController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (weatherController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(weatherController.errorMessage.value));
        } else if (weatherController.weatherData.isNotEmpty) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              children: [
                CurrentWeatherDisplay(
                  weatherData: weatherController.weatherData,
                  cityName: geoNamesController.selectedCityName.value,
                  onRefresh: () => _loadWeather(),
                ),
                const SizedBox(height: 10.0),
                HourlyForecast(weatherData: weatherController.weatherData),
                const SizedBox(height: 10.0),
                DailyForecast(weatherData: weatherController.weatherData),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No weather data available.'));
        }
      }),
    );
  }
}
