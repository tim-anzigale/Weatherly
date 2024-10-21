import 'package:get/get.dart';
import 'package:weatherly/data/remote/api_checker.dart';
import 'package:weatherly/data/repositories/geonames_repository.dart';

class GeoNamesController extends GetxController {
  final GeoNamesRepository geoNamesRepository;

  // Observable variables to manage state
  var isLoading = false.obs;
  var searchResults = <Map<String, dynamic>>[].obs; 
  var selectedCityName = ''.obs;

  GeoNamesController({required this.geoNamesRepository});

  // Function to search cities based on user input
 Future<void> searchCities(String query) async {
  if (query.isEmpty) {
    searchResults.clear();
    return;
  }

  isLoading.value = true;
  final response = await geoNamesRepository.searchCity(query: query);

  // Use ApiChecker to validate the API response
  if (response.statusCode == 200 && response.body['geonames'] != null) {
    // Ensure that you're casting to the expected type
    List<dynamic> geonames = response.body['geonames'];

    // Assign the full maps to searchResults
    searchResults.value = geonames.cast<Map<String, dynamic>>();

    ApiChecker.checkApi(response);
  } else {
    // Handle the error using ApiChecker
    ApiChecker.checkApi(response);
  }

  isLoading.value = false;
}


  // Function to select a city and store its name in the state
  void selectCity(String cityName) {
    selectedCityName.value = cityName;
  }
}
