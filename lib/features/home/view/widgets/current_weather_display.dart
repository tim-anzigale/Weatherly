import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weatherly/core/base_widgets/glassmorphism.dart';

class CurrentWeatherDisplay extends StatelessWidget {
  final Map<String, dynamic> weatherData;
  final String? cityName;
  final VoidCallback onRefresh;

  const CurrentWeatherDisplay({
    super.key,
    required this.weatherData,
    this.cityName,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final current = weatherData['current'];
    final temp = current['temp'];
    final humidity = current['humidity'];
    final windSpeed = current['wind_speed'];
    final weather = current['weather'][0];
    final icon = weather['icon'];
    final description = weather['description'];

    return GlassMorphism(
      blur: 20.0,
      opacity: 0.1,
      color: const Color.fromARGB(255, 106, 50, 50),
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display the city name or 'Current Location' as a fallback
                Text(
                  cityName ?? 'Current Location',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 25, 22, 22),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Color.fromARGB(255, 109, 57, 57)),
                  onPressed: onRefresh,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/$icon.png',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 16.0),
                Text(
                  '$temp°C',
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 168, 143, 143),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Center(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 117, 96, 96),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.speed,
                      color: Color.fromARGB(255, 142, 108, 108),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Wind: $windSpeed m/s',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 116, 91, 91),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.water_drop,
                      color: Color.fromARGB(255, 139, 113, 113),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Humidity: $humidity%',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 133, 108, 108),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
