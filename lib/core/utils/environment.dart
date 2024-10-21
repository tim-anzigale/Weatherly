import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // Base URL for OpenWeather API
  static String get openWeatherBaseUrl =>
      dotenv.env['OPEN_WEATHER_URL'] ?? 'MY_FALLBACK';

  // API Key for accessing OpenWeather API
  static String get openWeatherApiKey =>
      dotenv.env['OPEN_WEATHER_API_KEY'] ?? 'MY_FALLBACK';

  static String get geoNamesBaseUrl =>
      dotenv.env['GEO_NAMES_URL'] ?? 'MY_FALLBACK';

  static String get geoNamesUsername =>
      dotenv.env['GEO_NAMES_USERNAME'] ?? 'MY_FALLBACK';

  // Endpoint for One Call API (Weather Data)
  static String get oneCallUrl => '/data/3.0/onecall';

  // Endpoint for Time Machine API (Historical Weather Data)
  static String get timeMachineUrl => '/data/3.0/onecall/timemachine';

  // Endpoints for Geocoding API
  static String get geocodingDirectUrl => '/geo/1.0/direct';
  static String get geocodingReverseUrl => '/geo/1.0/reverse';

  //Geo names endpoints 
  static String get geoNamesSearchUrl => '/searchJSON'; // For searching cities
  static String get geoNamesReverseUrl => '/findNearbyJSON'; // For reverse geocoding (optional)

}
