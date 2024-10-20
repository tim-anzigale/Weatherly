import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  final String apiKey;

  GeocodingService(this.apiKey);

  Future<Coordinates?> getCoordinates(String cityName) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final lat = data[0]['lat'];
        final lon = data[0]['lon'];
        return Coordinates(lat, lon);
      } else {
        throw Exception('No location data found');
      }
    } else {
      throw Exception('Failed to load location data: ${response.statusCode}');
    }
  }

  Future<String?> getCityName(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data[0]['name'];
      } else {
        throw Exception('No city name found');
      }
    } else {
      throw Exception('Failed to load city name: ${response.statusCode}');
    }
  }
}

class Coordinates {
  final double lat;
  final double lon;

  Coordinates(this.lat, this.lon);
}
