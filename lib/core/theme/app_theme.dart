import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkThemeData = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.scaffoldBackGroundColor,
    appBarTheme: const AppBarTheme(
      color: AppPallete.scaffoldBackGroundColor,
      elevation: 0,
    ),

    //text theme
    textTheme: const TextTheme(
      //display large
      displayLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        letterSpacing: .1,
        fontFamily: 'Inter',
      ),
      //display medium
      displayMedium: TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
      ),
      //display small
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppPallete.grayLight,
      selectionColor: AppPallete.grayLight,
      selectionHandleColor: AppPallete.grayLabel,
    ),
    snackBarTheme: const SnackBarThemeData(
      closeIconColor: AppPallete.errorColor,
      showCloseIcon: true,
      // actionTextColor: AppPallete.errorColor,
      backgroundColor: Color.fromARGB(255, 22, 22, 22),
      insetPadding: EdgeInsets.only(top: 20),
      contentTextStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white38,
      ),
    ),

    //input theme
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        color: AppPallete.grayLight,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 9,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: AppPallete.grayDark,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: AppPallete.grayDark,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: AppPallete.grayDark,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: AppPallete.grayDark,
        ),
      ),
      errorStyle: const TextStyle(
        fontSize: 14,
        height: .4,
        fontWeight: FontWeight.w400,
        color: AppPallete.errorColor,
      ),
      helperStyle: const TextStyle(
        fontSize: 14,
        height: .4,
        fontWeight: FontWeight.w400,
        color: AppPallete.grayLight,
      ),
    ),

    //tab bar theme
    tabBarTheme: const TabBarTheme(
      indicatorColor: AppPallete.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: EdgeInsets.symmetric(
        vertical: 15,
      ),
      labelStyle: TextStyle(
        fontSize: 16,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
      ),
      unselectedLabelColor: AppPallete.tabLabelUnselectedColor,
      labelColor: AppPallete.tabLabelSelectedColor,
      dividerHeight: 0,
    ),
  );
}
