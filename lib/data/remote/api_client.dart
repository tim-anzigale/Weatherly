import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weatherly/core/constants/api_constants.dart';
import 'handle_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String baseUrl;
  late final Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.baseUrl, required this.sharedPreferences}) {
    _mainHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<Response> getData(String uri) async {
    debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
    return _handleApiCall(
      http.get(Uri.parse(uri), headers: _mainHeaders),
      uri,
    );
  }

  Future<Response> getWithParamsData(String uri, {required Map<String, String> queryParams}) async {
    debugPrint(
          '====> API Call: $uri\nHeader: $_mainHeaders\nParams: $queryParams');
    return _handleApiCall(
      http.get(
        Uri.parse(uri).replace(queryParameters: queryParams),
        headers: _mainHeaders,
      ),
      uri,
    );
  }

  Future<Response> postData(String uri, dynamic body) async {
    return _handleApiCall(
      http.post(Uri.parse(uri), headers: _mainHeaders, body: jsonEncode(body)),
      uri,
    );
  }

  Future<Response> postWithParamsData(String uri, dynamic body, {required Map<String, String> queryParams}) async {
    return _handleApiCall(
      http.post(
        Uri.parse(uri).replace(queryParameters: queryParams),
        headers: _mainHeaders,
        body: jsonEncode(body),
      ),
      uri,
    );
  }

  Future<Response> _handleApiCall(Future<http.Response> apiCall, String uri) async {
    try {
      
      http.Response response = await apiCall.timeout(
        const Duration(seconds: ApiConstants.timeoutInSeconds),
      );
      return HandleResponse().handleResponse(response, uri);
    } catch (e) {
      debugPrint('Error making API call: $e');
      return const Response(
        statusCode: 0,
        statusText: ApiConstants.noInternetMessage,
      );
    }
  }
}
