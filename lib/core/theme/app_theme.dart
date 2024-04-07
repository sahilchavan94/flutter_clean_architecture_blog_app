import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkThemeData = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.scaffoldBackGroundColor,
    appBarTheme: const AppBarTheme(
      color: AppPallete.scaffoldBackGroundColor,
    ),

    //text theme
    textTheme: const TextTheme(
      //display large
      displayLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        letterSpacing: .1,
      ),
      //display medium
      displayMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      //display small
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
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
          vertical: 12,
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
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppPallete.errorColor,
        )),
  );
}
