import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/core/base_widgets/glassmorphism.dart';

class DailyForecast extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const DailyForecast({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final daily = weatherData['daily'];

    if (daily == null || daily.isEmpty) {
      return const Center(child: Text('No daily forecast data available'));
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: daily.length,
          itemBuilder: (context, index) {
            final day = daily[index];
            final tempMax = day['temp']['max'];
            final tempMin = day['temp']['min'];
            final icon = day['weather'][0]['icon'];
            final dt = DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000);
            final dayOfWeek = DateFormat('EEEE').format(dt);

            return Padding(
              padding: const EdgeInsets.only(bottom: 13.0), // Add spacing between items
              child: GlassMorphism(
                blur: 20.0,
                opacity: 0.1,
                color: Color.fromARGB(255, 151, 84, 84),
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                 
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Image.network(
                        'https://openweathermap.org/img/wn/$icon.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dayOfWeek,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 32, 29, 29),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'High: $tempMax°C, Low: $tempMin°C',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 74, 69, 69),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
