import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherly/core/theme/colors.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> themeData = ThemeData.light().obs;
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setInitialTheme();
  }

  void _setInitialTheme() {
    themeData.value = ThemeData.light().copyWith(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.lightBackground,
        surface: AppColors.lightSurface,
        onPrimary: AppColors.lightOnPrimary,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }

  void toggleTheme() {
    if (isDarkMode.value) {
      // Light theme
      themeData.value = ThemeData.light().copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.lightBackground,
          surface: AppColors.lightSurface,
          onPrimary: AppColors.lightOnPrimary,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textSecondary),
        ),
      );
    } else {
      // Dark theme
      themeData.value = ThemeData.dark().copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.darkBackground,
          surface: AppColors.darkSurface,
          onPrimary: AppColors.darkOnPrimary,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textSecondary),
        ),
        iconTheme: const IconThemeData(color: AppColors.secondary),
      );
    }
    isDarkMode.value = !isDarkMode.value;
  }
}
