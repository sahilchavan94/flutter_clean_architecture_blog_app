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
        fontSize: 19.5,
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
      cursorColor: AppPallete.grayDark,
      selectionColor: AppPallete.grayDark,
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
        color: AppPallete.grayDark,
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
        color: AppPallete.grayDark,
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

  static ThemeData lightThemeData = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.scaffoldBackGroundLightColor,

    appBarTheme: AppBarTheme(
      color: AppPallete.scaffoldBackGroundLightColor,
      elevation: 0,
      titleTextStyle: const TextStyle().copyWith(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 18,
        color: Colors.black,
      ),
    ),

    //text theme
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        letterSpacing: .1,
        fontFamily: GoogleFonts.inter().fontFamily,
        color: Colors.black,
      ),
      //display large
      displayLarge: TextStyle(
        fontSize: 19.5,
        fontWeight: FontWeight.w500,
        letterSpacing: .1,
        fontFamily: GoogleFonts.inter().fontFamily,
        color: Colors.black,
      ),
      //display medium
      displayMedium: TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w400,
        fontFamily: GoogleFonts.roboto().fontFamily,
        color: Colors.black,
      ),
      //display small
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: GoogleFonts.roboto().fontFamily,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 13.5,
        fontFamily: GoogleFonts.openSans().fontFamily,
        color: Colors.black,
      ),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppPallete.grayDark,
      selectionColor: AppPallete.grayDark,
      selectionHandleColor: AppPallete.grayLabel,
    ),
    snackBarTheme: const SnackBarThemeData(
      closeIconColor: AppPallete.errorColor,
      showCloseIcon: true,
      // actionTextColor: AppPallete.errorColor,
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      insetPadding: EdgeInsets.only(top: 20),
      contentTextStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.black54,
      ),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppPallete.primaryLightColor,
    ),

    //input theme
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppPallete.grayDark,
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
        color: AppPallete.grayDark,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    ),

    //tab bar theme
    tabBarTheme: TabBarTheme(
      indicatorColor: AppPallete.primaryLightColor,
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        fontFamily: GoogleFonts.inter().fontFamily,
        color: AppPallete.tabLabelSelectedColorLight,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontFamily: GoogleFonts.inter().fontFamily,
        color: AppPallete.grayDark,
      ),
      unselectedLabelColor: AppPallete.tabLabelUnselectedColorLight,
      labelColor: AppPallete.tabLabelSelectedColorLight,
      dividerHeight: 0,
    ),
  );
}
