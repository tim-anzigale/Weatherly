import 'package:get/get.dart';
import 'package:weatherly/core/utils/environment.dart';
import 'package:weatherly/data/remote/api_client.dart';

class GeoNamesRepository extends GetxService {
  final ApiClient apiClient;

  GeoNamesRepository({required this.apiClient});

  Future<Response> searchCity({
    required String query,
    int maxRows = 10,
    String lang = 'en',
  }) async {

    final String username = Environment.geoNamesUsername;
    final String uri = '${Environment.geoNamesBaseUrl}${Environment.geoNamesSearchUrl}';

    final Map<String, String> queryParams = {
      'q': query,
      'maxRows': maxRows.toString(),
      'lang': lang,
      'username': username,
    };

    return apiClient.getWithParamsData(uri, queryParams: queryParams);
  }
}
