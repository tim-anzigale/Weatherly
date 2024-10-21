import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherly/core/controllers/geocoding_controller.dart';
import 'package:weatherly/core/controllers/geonames_controller.dart';
import 'package:weatherly/core/controllers/weather_controller.dart';
import 'package:weatherly/core/utils/environment.dart';
import 'package:weatherly/data/remote/api_client.dart';
import 'package:weatherly/data/repositories/geocoding_repository.dart';
import 'package:weatherly/data/repositories/geonames_repository.dart';
import 'package:weatherly/data/repositories/weather_repository.dart';

Future<void> init() async {
  // Core
  Get.putAsync(() => SharedPreferences.getInstance());
  Get.lazyPut(() => ApiClient(
        baseUrl: Environment.openWeatherBaseUrl,
        sharedPreferences: Get.find(),
      ));

  // Repositories
  Get.lazyPut(() => WeatherRepository(apiClient: Get.find()));
  Get.lazyPut(() => GeocodingRepository(apiClient: Get.find()));
  Get.lazyPut(() => GeoNamesRepository(apiClient: Get.find()));

  // Controllers
  Get.lazyPut(() => WeatherController(weatherRepository: Get.find()));
  Get.lazyPut(() => GeocodingController(geocodingRepository: Get.find()));
  Get.lazyPut(() => GeoNamesController(geoNamesRepository: Get.find()));
}
