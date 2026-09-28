// ignore_for_file: constant_identifier_names

import 'package:rnw_institue/utils/app_export.dart';

class RnWThemeHelper {
  static ThemeData get lightTheme {
    return ThemeData(
        brightness: Brightness.light,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        visualDensity: VisualDensity.standard,
        primaryColor: Colors.transparent,
        primaryColorLight: Colors.transparent,
        navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(
            color: const Color(0XFF1D1D1D),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        )),
        textTheme: TextThemes.lighttextTheme(),
        tabBarTheme: const TabBarThemeData(
            overlayColor: WidgetStatePropertyAll(Colors.black),
            splashFactory: NoSplash.splashFactory),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffe31e25),
                disabledBackgroundColor:
                    const Color(0xffe31e25).withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0.r)),
                visualDensity:
                    const VisualDensity(vertical: -1, horizontal: -1),
                padding: EdgeInsets.zero)),
        colorScheme: ColorSchemes.lightColorSchemes);
  }

  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        visualDensity: VisualDensity.standard,
        navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: WidgetStatePropertyAll(GoogleFonts.poppins(
                color: const Color(0XFFD9D9D9),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400))),
        textTheme: TextThemes.darktextTheme(),
        tabBarTheme: const TabBarThemeData(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            splashFactory: NoSplash.splashFactory),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffe31e25),
                disabledBackgroundColor:
                    const Color(0xffe31e25).withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0.r)),
                visualDensity:
                    const VisualDensity(vertical: -1, horizontal: -1),
                padding: EdgeInsets.zero)),
        colorScheme: ColorSchemes.darkColorSchemes);
  }
}

class ColorSchemes {
  static const lightColorSchemes =
      ColorScheme.light(onError: Color(0xffe31e25), primary: Color(0xffe31e25));
  static const darkColorSchemes =
      ColorScheme.dark(onError: Color(0xffe31e25), primary: Color(0xffe31e25));
}

class TextThemes {
  static TextTheme lighttextTheme() => TextTheme(
        labelSmall: GoogleFonts.poppins(
          color: const Color(0XFFC4C4C4),
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: GoogleFonts.poppins(
          color: const Color(0XFFFF1D1D),
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
        labelLarge: GoogleFonts.poppins(
          color: const Color(0XFF000000),
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: const Color(0XFF000000),
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: const Color(0XFF000000),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.poppins(
          color: const Color(0XFF252520),
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: GoogleFonts.poppins(
          color: const Color(0XFF000000),
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: GoogleFonts.poppins(
          color: const Color(0XFF000000),
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: GoogleFonts.poppins(
          color: const Color(0XFF000000),
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static TextTheme darktextTheme() => TextTheme(
        labelSmall: GoogleFonts.poppins(
          color: const Color(0XFFFFFFFF),
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: GoogleFonts.poppins(
          color: const Color(0XFFFF1D1D),
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
        labelLarge: GoogleFonts.poppins(
          color: const Color(0XFFFFFFFF),
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: const Color(0XFFFFFFFF),
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: const Color(0XFFFFFFFF),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.poppins(
          color: const Color(0XFFFFFFFF),
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: GoogleFonts.poppins(
          color: const Color(0XFFFFFFFF),
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: GoogleFonts.poppins(
          color: const Color(0XFFFFFFFF),
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: GoogleFonts.poppins(
          color: const Color(0XFFE0E0E0),
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      );
}

class AppColors {
  static const Color bgcolor = Color(0XFFF9F9F9);
  static const Color blackcolor = Color(0XFF252520);
  static const Color whitecolor = Color(0XFFFFFFFF);
  static const Color selectedIconColor = Color(0XFF767D88);
  static const Color iconColor = Color(0XFFD7D7D7);
  static const Color unselectedLableColor = Color(0XFFD9D9D9);
  static const Color tealColor = Color(0XFF74FBDE);
  static const Color textHient = Colors.black45;
  static const Color arrowColor = Color(0XFF1D1D1D);
  static const Color borderColor = Color(0XFFCECECE);
  static const Color starColor = Color(0XFFFFD233);
  static const Color ratingcountcolor = Color(0XFFC4C4C4);
  static const Color lablecolor = Color(0XFFF0F0F0);
  static const Color lablecolor1 = Color(0XFF868686);
  static const Color sendiconcolor = Color(0XFFC8C8C8);
  static const Color grayColor = Color(0XFFEEEEEE);
  static const Color darkGrayColor = Color(0XFF616161);
  static const Color textgrayColor = Color(0XFFA0A0A0);
  static const Color btnColor = Color(0xffe31e25);
  static const Color primaryColor = Color(0xffe31e25);
  static const Color grayborderColor = Color(0XFF737373);
  static const Color graytextColor = Color(0XFFbcbcbc);
  static const Color grayBoxColor = Color(0xffebebeb);
  static const Color bluetextColor = Color(0xff0a537e);
  static const Color errorColor = Color(0XFFf1a2a5);
  static const Color grayColors = Color(0xff85929b);
  static const Color boxShadow = Colors.black26;
  static const Color dropdownColor = Color(0x61000000);
  static const Color textboldColor = Color(0xff2b2b2b);
  static const Color textColor = Color(0xff303030);
  static const Color greenColor = Colors.green;
  static const Color greyColor = Colors.grey;
  static const Color blackcolor54 = Colors.black54;
  static const Color blackcolors = Colors.black;
  
  static const Color PRIMERY_COLOR = Color(0xffe31e25);

  static const Color DARK_BLUE = Color(0xff0b527e);

  static const Color BLUE_GREY = Color(0xff88919A);

  static const Color BACK_GROUND = Color(0xffF9F9F9);

  static const Color BORDER = Color(0xff85929b);

  static const Color GREY = Color(0xffe8e8e8);

  static const Color DARK_GREY = Color(0xffdedede);

  static const Color LIGHT_GREY = Color(0xfffefefe);

  static const Color BLACK = Color(0xff2b2a28);

  static const Color FONT_COLOR = Color(0xff2b2b2b);

  // Courses tag colors
  static const Color ongoing = Color(0xffef9b0f);

  static const Color pending = Color(0xffa81b07);

  static const Color completed = Color(0xff0b6623);
}
