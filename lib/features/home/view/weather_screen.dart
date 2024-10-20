import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/core/controllers/geocoding_controller.dart';
import 'package:weatherly/core/controllers/weather_controller.dart';
import 'package:weatherly/core/services/geolocator_service.dart';
import 'package:weatherly/core/utils/cities.dart';
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

  String? selectedCity;
  String? cityName;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather({String? city}) async {
    try {
      double? latitude;
      double? longitude;

      if (city != null && city != 'Use My Location') {
        await geocodingController.fetchCoordinates(city);
        latitude = geocodingController.coordinates['lat'];
        longitude = geocodingController.coordinates['lon'];
      } else {
        Position position = await getCurrentLocation();
        latitude = position.latitude;
        longitude = position.longitude;
        selectedCity = 'Use My Location';
      }

      await weatherController.fetchWeatherData(latitude!, longitude!);

      if (city == null || city == 'Use My Location') {
        await geocodingController.fetchCityName(latitude, longitude);
        cityName = geocodingController.cityName.value;
      } else {
        cityName = city;
      }
    } catch (e) {
      weatherController.errorMessage.value = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: false,
                      value: selectedCity,
                      hint: const Text('Select a City'),
                      items: [
                        const DropdownMenuItem<String>(
                          value: 'Use My Location',
                          child: Text('My Location'),
                        ),
                        ...kenyanCities.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          selectedCity = newValue;
                        });
                        _loadWeather(city: newValue);
                      },
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () => _loadWeather(),
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
                  cityName: cityName,
                  onRefresh: () => _loadWeather(city: selectedCity),
                ),
                const SizedBox(height: 10.0),
                HourlyForecast(weatherData: weatherController.weatherData),
                const SizedBox(height: 10.0),
                DailyForecast(weatherData: weatherController.weatherData),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No weather data available'));
        }
      }),
    );
  }
}
