class City {
  final String name;
  final double lat;
  final double lon;

  City({required this.name, required this.lat, required this.lon});
}

class CitySearchResult {
  final String name; // Name of the city
  final String country; // Country of the city (optional)
  final double? latitude; // Latitude of the city (optional)
  final double? longitude; // Longitude of the city (optional)

  CitySearchResult({
    required this.name,
    required this.country,
    this.latitude,
    this.longitude,
  });

  // Factory method to create an instance from a map
  factory CitySearchResult.fromMap(Map<String, dynamic> map) {
    return CitySearchResult(
      name: map['name'],
      country: map['country'] ?? '', // Handle optional country
      latitude: map['lat']?.toDouble(),
      longitude: map['lon']?.toDouble(),
    );
  }

  // Method to convert the instance to a map (if needed)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'country': country,
      'lat': latitude,
      'lon': longitude,
    };
  }
}
