import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/core/base_widgets/glassmorphism.dart';


class HourlyForecast extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const HourlyForecast({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final hourly = weatherData['hourly'];

    if (hourly == null || hourly.isEmpty) {
      return const Center(child: Text('No hourly forecast data available'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align cards horizontally from the start
        children: hourly.map<Widget>((hour) {
          final temp = hour['temp'].toInt();
          final humidity = hour['humidity'];
          final windSpeed = hour['wind_speed'].toStringAsFixed(1);
          final icon = hour['weather'][0]['icon'];
          final dt = DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000);
          final time = DateFormat('HH:mm').format(dt);

          return Container(
            margin: const EdgeInsets.only(right: 13.0), // Add margin to the right for spacing
            child: GlassMorphism(
              blur: 20.0,
              opacity: 0.1,
              color: const Color.fromARGB(255, 91, 49, 49),
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: 140,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(color: Color.fromARGB(255, 84, 77, 77), fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Image.network('https://openweathermap.org/img/wn/$icon.png'),
                    const SizedBox(height: 8.0),
                    Text('$temp°C', style: const TextStyle(color: Color.fromARGB(255, 73, 54, 54))),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.water_drop,
                          color: Color.fromARGB(255, 90, 71, 71),
                          size: 16.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text('$humidity%', style: const TextStyle(color: Color.fromARGB(255, 78, 61, 61))),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.air,
                          color: Color.fromARGB(255, 96, 80, 80),
                          size: 16.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text('$windSpeed m/s', style: const TextStyle(color: Color.fromARGB(255, 78, 67, 67))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
