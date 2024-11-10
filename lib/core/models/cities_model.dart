class City {
  final String id; // Unique ID from MongoDB
  final String name;
  final String country;
  final double lat;
  final double lon;
  final int? population; // Optional field

  City({
    required this.id,
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    this.population,
  });

  // Factory method to create an instance from a map
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'],
      name: map['name'],
      country: map['country'] ?? '',
      lat: double.parse(map['lat'].toString()),
      lon: double.parse(map['lon'].toString()),
      population: map['pop'] != null ? int.parse(map['pop'].toString()) : null,
    );
  }

  // Method to convert the instance to a map (if needed)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'lat': lat,
      'lon': lon,
      'pop': population,
    };
  }
}

class CitySearchResult {
  final String name;
  final String? country;
  final double? latitude;
  final double? longitude;

  CitySearchResult({
    required this.name,
    this.country,
    this.latitude,
    this.longitude,
  });

  // Factory method to create an instance from a map
  factory CitySearchResult.fromMap(Map<String, dynamic> map) {
    return CitySearchResult(
      name: map['name'],
      country: map['country'] ?? '',
      latitude: map['lat'] != null ? double.parse(map['lat'].toString()) : null,
      longitude: map['lon'] != null ? double.parse(map['lon'].toString()) : null,
    );
  }

  // Method to convert the instance to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'country': country,
      'lat': latitude,
      'lon': longitude,
    };
  }
}



