import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:weatherly/core/constants/api_constants.dart';
import 'package:weatherly/core/constants/app_strings.dart';
import 'package:weatherly/core/models/error_response.dart';

class HandleResponse {
  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      debugPrint('Error decoding response body: $e');
      body = response.body; // Use raw body if decoding fails
    }

    Response responseObj = Response(
      body: body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request?.headers ?? {},
        method: response.request?.method ?? 'GET',
        url: response.request?.url ?? Uri(),
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (responseObj.statusCode != 200) {
      _handleError(responseObj);
    }

    debugPrint('====> API Response: [${responseObj.statusCode}] $uri\n${responseObj.body}');
    return responseObj;
  }

  void _handleError(Response responseObj) {
    String errorMessage = ApiConstants.defaultErrorMessage;

    if (responseObj.body is Map<String, dynamic>) {
      try {
        // Try parsing the error using the ErrorResponse model
        ErrorResponse errorResponse = ErrorResponse.fromJson(responseObj.body);
        errorMessage = errorResponse.error; // Use the 'error' field from the ErrorResponse model
      } catch (e) {
        // If parsing fails, use fallback logic
        Map<String, dynamic> responseBody = responseObj.body;
        if (responseBody.containsKey(ApiConstants.apiErrorKey)) {
          errorMessage = responseBody[ApiConstants.apiErrorKey];
        } else if (responseBody.containsKey(ApiConstants.apiMessageKey)) {
          errorMessage = responseBody[ApiConstants.apiMessageKey];
        }
      }
    }

    // Display the error message using Get.snackbar
    Get.snackbar(AppStrings.error, errorMessage, snackPosition: SnackPosition.BOTTOM);
  }
}
