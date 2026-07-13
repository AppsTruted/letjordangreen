import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ThemeProvider {
  static Map<String, CustomTheme> themes = {
    "Default".toLowerCase(): AVAILABLE_THEMES[0],  // Default theme
    "Dark".toLowerCase(): AVAILABLE_THEMES[1],     // Dark theme
    "Ocean Breeze".toLowerCase(): AVAILABLE_THEMES[2],  // Ocean Breeze theme
    "Sunset Glow".toLowerCase(): AVAILABLE_THEMES[3],  // Sunset Glow theme
    "Forest Mist".toLowerCase(): AVAILABLE_THEMES[4],  // Forest Mist theme
    "Lunar Night".toLowerCase(): AVAILABLE_THEMES[5],  // Lunar Night theme
  };

  static CustomTheme getThemeByName(String themeName) {
   // log("themes[themeName.toLowerCase()] ${themeName.toLowerCase()} ${themeName} ${themes[themeName.toLowerCase()]}");
    return themes[themeName.toLowerCase()] ?? AVAILABLE_THEMES[0];  // Default fallback
  }
}
class CustomTheme {
  final String name;
  final String? previewImage;
  final Map<String, String> properties;

  CustomTheme({
    required this.name,
    this.previewImage,
    required this.properties,
  });

  @override
  String toString() {
    return 'CustomTheme{name: $name, previewImage: $previewImage, properties: $properties}';
  }
}

// Define the available themes
final AVAILABLE_THEMES = [
  CustomTheme(
    name: "Default".toLowerCase(),
    previewImage: "assets/themes/1.png", // Replace with your image path
    properties: {
      "theme-primary-bg": "#F4F2EE", // Off-white background
      "theme-secondary-bg": "#FFFFFF", // White for cards
      "theme-primary-text": "#584239", // Dark brown text
      "theme-secondary-text": "#A58E74", // Lighter brown text
      "theme-accent-color": "#3D837D", // Teal for active links/icons
      "theme-border-color": "#EAE5DE", // Light border color
      "theme-header-bg": "#584239", // Dark brown for headers
      "theme-header-text": "#FFFFFF", // White text for headers
    },
  ),
  CustomTheme(
    name: "Dark".toLowerCase(),
    previewImage: "assets/themes/2.png", // Replace with your image path
    properties: {
      "theme-primary-bg": "#212121", // Darker background
      "theme-secondary-bg": "#424242", // Dark secondary background
      "theme-primary-text": "#e0e0e0", // Light grey text
      "theme-secondary-text": "#9e9e9e", // Slightly darker grey text
      "theme-accent-color": "#bb86fc", // Purple for accent
      "theme-border-color": "#333333", // Darker border color
      "theme-header-bg": "#1f1f1f", // Very dark grey for headers
      "theme-header-text": "#ffffff", // White text for headers
    },
  ),
  CustomTheme(
    name: "Ocean Breeze".toLowerCase(),
    previewImage: "assets/themes/3.png", // Replace with your image path
    properties: {
      "theme-primary-bg": "#e0f7fa", // Light cyan background
      "theme-secondary-bg": "#ffffff", // White for cards
      "theme-primary-text": "#00796b", // Dark cyan text
      "theme-secondary-text": "#004d40", // Darker cyan text
      "theme-accent-color": "#0288d1", // Blue accent color
      "theme-border-color": "#b2dfdb", // Soft cyan border
      "theme-header-bg": "#00796b", // Cyan green header
      "theme-header-text": "#ffffff", // White text for headers
    },
  ),
  CustomTheme(
    name: "Sunset Glow".toLowerCase(),
    previewImage: "assets/themes/4.png", // Replace with your image path
    properties: {
      "theme-primary-bg": "#ffebee", // Light pink background
      "theme-secondary-bg": "#ffffff", // White for cards
      "theme-primary-text": "#c2185b", // Dark pink text
      "theme-secondary-text": "#880e4f", // Darker pink text
      "theme-accent-color": "#f44336", // Red for accent
      "theme-border-color": "#f8bbd0", // Light pink border
      "theme-header-bg": "#c2185b", // Dark pink header
      "theme-header-text": "#ffffff", // White text for headers
    },
  ),
  CustomTheme(
    name: "Forest Mist".toLowerCase(),
    previewImage: "assets/themes/5.png", // Replace with your image path
    properties: {
      "theme-primary-bg": "#e8f5e9", // Light green background
      "theme-secondary-bg": "#ffffff", // White for cards
      "theme-primary-text": "#388e3c", // Dark green text
      "theme-secondary-text": "#2c6e28", // Darker green text
      "theme-accent-color": "#8bc34a", // Light green accent
      "theme-border-color": "#c8e6c9", // Soft green border
      "theme-header-bg": "#388e3c", // Green header
      "theme-header-text": "#ffffff", // White text for headers
    },
  ),
  CustomTheme(
    name: "Lunar Night".toLowerCase(),
    previewImage: "assets/themes/6.png", // Replace with your image path
    properties: {
      "theme-primary-bg": "#212121", // Dark grey background
      "theme-secondary-bg": "#424242", // Medium grey for cards
      "theme-primary-text": "#e0e0e0", // Light grey text
      "theme-secondary-text": "#9e9e9e", // Darker grey text
      "theme-accent-color": "#ff9800", // Orange accent
      "theme-border-color": "#616161", // Dark grey border
      "theme-header-bg": "#ff5722", // Orange header
      "theme-header-text": "#ffffff", // White text for headers
    },
  ),
];


abstract class BaseColorScheme {
  Color get primaryBg;
  Color get secondaryBg;
  Color get primaryText;
  Color get secondaryText;
  Color get accent;
  Color get border;
  Color get headerBg;
  Color get headerText;
}

class DefaultColors implements BaseColorScheme {
  @override Color get primaryBg => const Color(0xFFF4F2EE);
  @override Color get secondaryBg => const Color(0xFFFFFFFF);
  @override Color get primaryText => const Color(0xFF584239);
  @override Color get secondaryText => const Color(0xFFA58E74);
  @override Color get accent => const Color(0xFF3D837D);
  @override Color get border => const Color(0xFFEAE5DE);
  @override Color get headerBg => const Color(0xFF584239);
  @override Color get headerText => const Color(0xFFFFFFFF);
}

class DarkColors implements BaseColorScheme {
  @override Color get primaryBg => const Color(0xFF212121);
  @override Color get secondaryBg => const Color(0xFF424242);
  @override Color get primaryText => const Color(0xFFE0E0E0);
  @override Color get secondaryText => const Color(0xFF9E9E9E);
  @override Color get accent => const Color(0xFFBB86FC);
  @override Color get border => const Color(0xFF333333);
  @override Color get headerBg => const Color(0xFF1F1F1F);
  @override Color get headerText => const Color(0xFFFFFFFF);
}

class OceanBreezeColors implements BaseColorScheme {
  @override Color get primaryBg => const Color(0xFFE0F7FA);
  @override Color get secondaryBg => const Color(0xFFFFFFFF);
  @override Color get primaryText => const Color(0xFF00796B);
  @override Color get secondaryText => const Color(0xFF004D40);
  @override Color get accent => const Color(0xFF0288D1);
  @override Color get border => const Color(0xFFB2DFDB);
  @override Color get headerBg => const Color(0xFF00796B);
  @override Color get headerText => const Color(0xFFFFFFFF);
}

class SunsetGlowColors implements BaseColorScheme {
  @override Color get primaryBg => const Color(0xFFFFEBEE);
  @override Color get secondaryBg => const Color(0xFFFFFFFF);
  @override Color get primaryText => const Color(0xFFC2185B);
  @override Color get secondaryText => const Color(0xFF880E4F);
  @override Color get accent => const Color(0xFFF44336);
  @override Color get border => const Color(0xFFF8BBD0);
  @override Color get headerBg => const Color(0xFFC2185B);
  @override Color get headerText => const Color(0xFFFFFFFF);
}

class ForestMistColors implements BaseColorScheme {
  @override Color get primaryBg => const Color(0xFFE8F5E9);
  @override Color get secondaryBg => const Color(0xFFFFFFFF);
  @override Color get primaryText => const Color(0xFF388E3C);
  @override Color get secondaryText => const Color(0xFF2C6E28);
  @override Color get accent => const Color(0xFF8BC34A);
  @override Color get border => const Color(0xFFC8E6C9);
  @override Color get headerBg => const Color(0xFF388E3C);
  @override Color get headerText => const Color(0xFFFFFFFF);
}
class LunarNightColors implements BaseColorScheme {
  @override Color get primaryBg => const Color(0xFF212121);
  @override Color get secondaryBg => const Color(0xFF424242);
  @override Color get primaryText => const Color(0xFFE0E0E0);
  @override Color get secondaryText => const Color(0xFF9E9E9E);
  @override Color get accent => const Color(0xFFFF9800);
  @override Color get border => const Color(0xFF616161);
  @override Color get headerBg => const Color(0xFFFF5722);
  @override Color get headerText => const Color(0xFFFFFFFF);
}


// final availableThemes = [
//   AppTheme(
//     name: "Default",
//     previewImage: "assets/themes/1.png",
//     colors: DefaultColors(),
//   ),
//   AppTheme(
//     name: "Dark",
//     previewImage: "assets/themes/2.png",
//     colors: DarkColors(),
//   ),
//   AppTheme(
//     name: "Ocean Breeze",
//     previewImage: "assets/themes/3.png",
//     colors: OceanBreezeColors(),
//   ),
//   AppTheme(
//     name: "Sunset Glow",
//     previewImage: "assets/themes/4.png",
//     colors: SunsetGlowColors(),
//   ),
//   AppTheme(
//     name: "Forest Mist",
//     previewImage: "assets/themes/5.png",
//     colors: ForestMistColors(),
//   ),
//   AppTheme(
//     name: "Lunar Night",
//     previewImage: "assets/themes/6.png",
//     colors: LunarNightColors(),
//   ),
// ];