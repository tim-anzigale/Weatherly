
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherly/features/home/view/weather_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAll(() => const WeatherScreen());
    });

    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 110, 59), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              'Weatherly',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
