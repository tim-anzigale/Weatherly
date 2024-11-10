import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:weatherly/core/base_widgets/custom_search_bar.dart';
import 'package:weatherly/core/controllers/geonames_controller.dart';
import 'package:weatherly/core/controllers/weather_controller.dart';
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
  final GeoNamesController geoNamesController = Get.find<GeoNamesController>();
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    weatherController.fetchWeatherForCurrentLocation();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  /// Debounce search to reduce API calls
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty && query.length >= 3) {
        geoNamesController.searchCities(query);
      }
    });
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
                child: Obx(
                  () => CustomSearchBar(
                    controller: searchController,
                    onChanged: _onSearchChanged,
                    onClear: () {
                      searchController.clear();
                      geoNamesController.searchResults.clear();
                    },
                    hintText: 'Search for cities...',
                    searchResults: geoNamesController.searchResults
                        .map<String>((result) => result.name)
                        .toList(),
                    onResultSelected: (String city) async {
                      final selectedCity = geoNamesController.searchResults
                          .firstWhere((result) => result.name == city);
                      geoNamesController.selectCity(selectedCity);
                      await weatherController.fetchWeatherForCity(selectedCity);
                      searchController.clear();
                    },
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () => weatherController.fetchWeatherForCurrentLocation(),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (weatherController.isLoading.value) {
          return const Center(
            child: SpinKitWaveSpinner(
              color: Colors.blue,
              size: 70.0,
            ),
          );
        } else if (weatherController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              weatherController.errorMessage.value,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        } else if (weatherController.weatherData.isNotEmpty) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              children: [
                CurrentWeatherDisplay(
                  weatherData: weatherController.weatherData,
                  cityName: weatherController.selectedCityName.value,
                  onRefresh: () => weatherController.fetchWeatherForCurrentLocation(),
                ),
                const SizedBox(height: 10.0),
                HourlyForecast(weatherData: weatherController.weatherData),
                const SizedBox(height: 10.0),
                DailyForecast(weatherData: weatherController.weatherData),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('No weather data available.'),
          );
        }
      }),
    );
  }
}
