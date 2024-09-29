import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/shared/constants/colors.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    Color? secondaryText,
    required Color accentColor,
    Color? divider,
    Color? buttonBackground,
    required Color buttonText,
    Color? cardBackground,
    Color? disabled,
    required Color error,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      brightness: brightness,
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(buttonBackground!),
        ),
      ),
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accentColor,
        // primaryVariant: accentColor,
        secondary: accentColor,
        // secondaryVariant: accentColor,
        surface: background,
        error: error,
        onPrimary: buttonText,
        onSecondary: buttonText,
        onSurface: buttonText,
        onError: buttonText,
      ),
      primaryColor: accentColor,
      // textSelectionColor: accentColor,
      // textSelectionHandleColor: accentColor,
      // cursorColor: accentColor,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor,
        selectionHandleColor: accentColor,
        cursorColor: accentColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorConstants.appScaffoldBackgroundColor,
        foregroundColor: ColorConstants.appScaffoldBackgroundColor,
        surfaceTintColor: ColorConstants.appScaffoldBackgroundColor,
        titleTextStyle: TextStyle(
          fontFamily: 'Figtree',
          fontWeight: FontWeight.w600,
          fontSize: 16.0.sp,
          color: primaryText,
        ),
        color: cardBackground,
        iconTheme: IconThemeData(
          color: secondaryText,
          size: 16.0,
        ),
        centerTitle: true,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: accentColor,
          secondary: accentColor,
          surface: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(color: error),
        labelStyle: TextStyle(
          fontFamily: 'Figtree',
          fontWeight: FontWeight.w600,
          fontSize: 22.0,
          color: primaryText.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          color: secondaryText,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      fontFamily: 'Figtree',
      textTheme: TextTheme(
        displayLarge: baseTextTheme.displayLarge!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: baseTextTheme.displayMedium!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: baseTextTheme.displaySmall!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: baseTextTheme.headlineLarge!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: baseTextTheme.headlineMedium!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: baseTextTheme.headlineSmall!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: baseTextTheme.titleLarge!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: baseTextTheme.titleMedium!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: baseTextTheme.titleSmall!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: baseTextTheme.bodyMedium!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: baseTextTheme.bodySmall!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: baseTextTheme.labelLarge!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        // Mobil font size used in datepicker: labelLarge,: 18 bodyLarge: 18, titleSmall: 18, headlineLarge: 22
        labelMedium: baseTextTheme.labelMedium!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
        labelSmall: baseTextTheme.labelSmall!.copyWith(
          fontFamily: 'Figtree',
          color: primaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static ThemeData get mainTheme => createTheme(
        brightness: Brightness.light,
        background: ColorConstants.appScaffoldBackgroundColor,
        // cardBackground: ColorConstants.secondaryAppColor,
        primaryText: ColorConstants.mainTextColor,
        secondaryText: ColorConstants.mainTextColor,
        accentColor: ColorConstants.primaryAccentColor,
        divider: ColorConstants.mainTextColor,
        buttonBackground: Colors.black38,
        buttonText: ColorConstants.primaryAccentColor,
        disabled: ColorConstants.inactiveLight,
        error: Colors.red,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        background: ColorConstants.appScaffoldBackgroundColor,
        // cardBackground: ColorConstants.secondaryDarkAppColor,
        primaryText: Colors.white,
        secondaryText: Colors.black,
        accentColor: ColorConstants.secondaryDarkAppColor,
        divider: Colors.black45,
        buttonBackground: Colors.white,
        buttonText: ColorConstants.secondaryDarkAppColor,
        disabled: ColorConstants.secondaryDarkAppColor,
        error: Colors.red,
      );
}
