
import 'package:flutter/material.dart';
import 'colorUtils.dart';
import 'textUtils.dart';



class Themes {
static String font1 = "JosefinSans";
  static String font2 = "JosefinSans";



  //constants color range for light theme
  //main color
  static const Color _lightPrimaryColor = primaryColor;

  //Background Colors
  static const Color _lightBackgroundColor = lightBackground;
  static const Color _lightBackgroundAppBarColor = _lightPrimaryColor;
  static const Color _lightBackgroundSecondaryColor = white;
  static const Color _lightBackgroundAlertColor = black;
  static const Color _lightBackgroundActionTextColor = white;


  //Text Colors
  static const Color _lightTextColor = black;
  static const Color _lightAlertTextColor = Colors.black;
  static const Color _lightTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _lightBorderColor = nevada;

  //Icon Color
  static const Color _lightIconColor = nevada;

  //form input colors
  static const Color _lightInputFillColor = _lightBackgroundSecondaryColor;
  static const Color _lightBorderActiveColor = _lightPrimaryColor;
  static const Color _lightBorderErrorColor = brinkPink;

  //constants color range for dark theme
  static const Color _darkPrimaryColor = primaryColor;

  //Background Colors
  static const Color _darkBackgroundColor = darkBackground;
  static const Color _darkBackgroundAppBarColor = _darkPrimaryColor;
  static const Color _darkBackgroundSecondaryColor =
      Color.fromRGBO(0, 0, 0, .6);
  static const Color _darkBackgroundAlertColor = black;
  static const Color _darkBackgroundActionTextColor = white;

  static const Color _darkBackgroundErrorColor =
      Color.fromRGBO(255, 97, 136, 1);
  static const Color _darkBackgroundSuccessColor =
      Color.fromRGBO(186, 215, 97, 1);

  //Text Colors
  static const Color _darkTextColor = Colors.white;
  static const Color _darkAlertTextColor = Colors.black;
  static const Color _darkTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _darkBorderColor = nevada;

  //Icon Color
  static const Color _darkIconColor = nevada;

  static const Color _darkInputFillColor = _darkBackgroundSecondaryColor;
  static const Color _darkBorderActiveColor = _darkPrimaryColor;
  static const Color _darkBorderErrorColor = brinkPink;

  static double letterSpace = 0.0;
  static double wordSpaceLight = 0.0;
  static double wordSpaceMedium = 0.0;
  static double wordSpaceRegular = 0.0;
  static double wordSpaceBold = 0.0;

  //text theme for light theme
  static final TextTheme _lightTextTheme = TextTheme(
    headline1: TextStyle(
        fontSize: TextUtils.superHeaderTextSize,
        color: _lightTextColor,
        fontFamily: font1,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceRegular),
    bodyText1: TextStyle(
        fontSize: TextUtils.commonTextSize,
        color: _lightTextColor,
        fontFamily: font1,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceRegular,
        fontWeight: TextUtils.normalTextWeight),
    bodyText2: TextStyle(
        fontSize: TextUtils.hintTextSize,
        color: Colors.grey,
        fontFamily: font1,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceLight),
    button: TextStyle(
        fontSize: TextUtils.commonTextSize,
        color: _darkTextColor,
        fontWeight: FontWeight.w600,
        fontFamily: font1,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceRegular),
    headline6: TextStyle(
      fontSize: TextUtils.headerTextSize,
      color: _lightTextColor,
      fontFamily: font1,
      letterSpacing: letterSpace,
      wordSpacing: wordSpaceBold,
      fontWeight: TextUtils.headerTextWeight,
    ),
    subtitle1: TextStyle(
        fontSize: TextUtils.commonTextSize,
        color: _lightTextColor,
        fontFamily: font1,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceLight),
    caption: TextStyle(
        fontSize: TextUtils.smallTextSize,
        color: _lightTextColor,
        fontFamily: font1,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceLight),
  );

  //text theme for dark theme
  static final TextTheme _darkTextTheme = TextTheme(
    headline1: TextStyle(
        fontSize: TextUtils.superHeaderTextSize,
        color: _darkTextColor,
        fontFamily: font2,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceRegular),
    bodyText1: TextStyle(
        fontSize: TextUtils.commonTextSize,
        color: _darkTextColor,
        fontFamily: font2,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceRegular,
        fontWeight: TextUtils.normalTextWeight),
    bodyText2: TextStyle(
        fontSize: TextUtils.hintTextSize,
        color: Colors.grey,
        fontFamily: font2,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceLight),
    button: TextStyle(
        fontSize: TextUtils.commonTextSize,
        color: _darkTextColor,
        fontWeight: FontWeight.w600,
        fontFamily: font2,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceRegular),
    headline6: TextStyle(
        fontSize: TextUtils.headerTextSize,
        color: _darkTextColor,
        fontFamily: font2,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceBold,
        fontWeight: TextUtils.headerTextWeight),
    subtitle1: TextStyle(
        fontSize: TextUtils.commonTextSize,
        color: _darkTextColor,
        fontFamily: font2,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceLight),
    caption: TextStyle(
        fontSize: TextUtils.smallTextSize,
        color: _darkTextColor,
        fontFamily: font2,
        letterSpacing: letterSpace,
        wordSpacing: wordSpaceLight),
  );

  final lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    //primarySwatch: _darkPrimaryColor, //cant be Color on MaterialColor so it can compute different shades.
    accentColor: secondaryColor,
    //prefix icon color form input on focus
    scaffoldBackgroundColor: _lightBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _lightBackgroundAppBarColor,
      iconTheme: IconThemeData(color: _lightTextColor),
      textTheme: _lightTextTheme,
    ),
    colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        primaryVariant: _lightBackgroundColor,
        secondary: secondaryColor
        // secondary: _lightSecondaryColor,
        ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: _lightBackgroundAlertColor,
        actionTextColor: _lightBackgroundActionTextColor),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightBackgroundAppBarColor),
    textTheme: _lightTextTheme,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: _lightPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _lightPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      //prefixStyle: TextStyle(color: _lightIconColor),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderActiveColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      fillColor: _lightBackgroundSecondaryColor,
      //focusColor: _lightBorderActiveColor,
    ),
  );

  final darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    //primarySwatch: _darkPrimaryColor, //cant be Color on MaterialColor so it can compute different shades.
    accentColor: _darkPrimaryColor,
    //prefix icon color form input on focus

    scaffoldBackgroundColor: _darkBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _darkBackgroundAppBarColor,
      iconTheme: IconThemeData(color: _darkTextColor),
      textTheme: _darkTextTheme,
    ),
    colorScheme: ColorScheme.dark(
        primary: _darkPrimaryColor,
        primaryVariant: _darkBackgroundColor,
        secondary: secondaryColor

        // secondary: _darkSecondaryColor,
        ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(color: Colors.white),
        backgroundColor: _darkBackgroundAlertColor,
        actionTextColor: _darkBackgroundActionTextColor),
    iconTheme: IconThemeData(
      color: _darkIconColor, //_darkIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _darkBackgroundAppBarColor),
    textTheme: _darkTextTheme,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: _darkPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _darkPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      prefixStyle: TextStyle(color: _darkIconColor),
      //labelStyle: TextStyle(color: nevada),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderActiveColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      fillColor: _darkInputFillColor,
      //focusColor: _darkBorderActiveColor,
    ),
  );
}
