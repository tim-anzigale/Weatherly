// lib/data/remote/api_checker.dart


import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weatherly/core/constants/api_constants.dart';
import 'package:weatherly/core/constants/app_strings.dart';



class ApiChecker {
  static void checkApi(Response response) {
    String errorMessage = ApiConstants.defaultErrorMessage;

    switch (response.statusCode) {
      case 200:
        _showSuccess(ApiConstants.defaultSuccessMessage);
        break;
      case 401:
        errorMessage = ApiConstants.unauthorizedMessage;
        //Get.find<AuthController>().logOut();
        _showError(errorMessage);
        break;
      default:
        _showError(errorMessage);
        break;
    }
  }

  static void _showError(String message) {
    Get.snackbar(AppStrings.error, message, snackPosition: SnackPosition.BOTTOM);
  }

  static void _showSuccess(String message) {
    Get.snackbar(AppStrings.success, message, snackPosition: SnackPosition.BOTTOM);
  }
}
