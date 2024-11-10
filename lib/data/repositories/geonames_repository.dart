import 'package:get/get.dart';
import 'package:weatherly/core/utils/environment.dart';
import 'package:weatherly/data/remote/api_client.dart';

class GeoNamesRepository extends GetxService {
  final ApiClient apiClient;

  GeoNamesRepository({required this.apiClient});

  // Function to search cities by name using the backend endpoint
  Future<Response> searchCity(String query) async {
    final String uri = '${Environment.geoNamesBaseUrl}${Environment.geoNamesSearchUrl}';
    
    // Pass the query as a parameter to the backend
    final Map<String, String> queryParams = {
      'name': query,
    };

    return await apiClient.getWithParamsData(uri, queryParams: queryParams);
  }
}
