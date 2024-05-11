import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData darkThemeData = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.scaffoldBackGroundColor,

    appBarTheme: AppBarTheme(
      color: AppPallete.scaffoldBackGroundColor,
      elevation: 0,
      titleTextStyle: const TextStyle().copyWith(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 18,
      ),
    ),

    //text theme
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        letterSpacing: .1,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      //display large
      displayLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w500,
        letterSpacing: .1,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      //display medium
      displayMedium: TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w400,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      //display small
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 13.5,
        fontFamily: GoogleFonts.openSans().fontFamily,
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

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppPallete.primaryColor,
    ),

    //input theme
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppPallete.grayLight,
        fontFamily: GoogleFonts.roboto().fontFamily,
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
      errorStyle: TextStyle(
        fontSize: 14,
        height: .4,
        fontWeight: FontWeight.w400,
        color: AppPallete.errorColor,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      helperStyle: TextStyle(
        fontSize: 14,
        height: .4,
        fontWeight: FontWeight.w400,
        color: AppPallete.grayLight,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    ),

    //tab bar theme
    tabBarTheme: TabBarTheme(
      indicatorColor: AppPallete.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      unselectedLabelColor: AppPallete.tabLabelUnselectedColor,
      labelColor: AppPallete.tabLabelSelectedColor,
      dividerHeight: 0,
    ),
  );
}
