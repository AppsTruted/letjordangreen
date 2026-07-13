import 'package:flutter/material.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';

final enTheme = ThemeData(
  fontFamily:  "SFProDisplay",
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    }),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor, primary: Colors.blue),
    dividerTheme: const DividerThemeData(color: Colors.transparent),
    dividerColor: Colors.transparent,
    dialogTheme: const DialogThemeData(surfaceTintColor: Colors.white),
    dialogBackgroundColor: Colors.white,

    textTheme:   TextTheme(
      bodyLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 14.5, color: Colors.black),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
      bodySmall: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black),
    ),

    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 8,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),

    /// Bottom Navigation Bar Theme
    bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
      selectedItemColor: Colors.transparent,
      unselectedItemColor: Colors.transparent,
      backgroundColor: Colors.white,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return AppColors.cardColor;
      }),

    )),
    brightness: Brightness.light,
    // primarycolor: AppColors.primarycolor,
    scaffoldBackgroundColor: AppColors.greyScaffoldColor,
    hintColor: Colors.grey,
    // cardColor: Colors.white,
    cardTheme: CardThemeData(
      elevation: 0.5,
      color: AppColors.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

    ),
    progressIndicatorTheme:
    const ProgressIndicatorThemeData(color: AppColors.primaryColor),
    floatingActionButtonTheme:  const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.primaryColor,
    ),


    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide:  const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(8),
        )));


