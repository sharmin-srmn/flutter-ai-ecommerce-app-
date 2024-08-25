import 'package:final_project_shopping_app/utils/theme/appbar_theme.dart';
import 'package:final_project_shopping_app/utils/theme/bottom_sheet_theme.dart';
import 'package:final_project_shopping_app/utils/theme/checkbox_theme.dart';
import 'package:final_project_shopping_app/utils/theme/chip_theme.dart';
import 'package:final_project_shopping_app/utils/theme/drawer_theme.dart';
import 'package:final_project_shopping_app/utils/theme/elevated_button_theme.dart';
import 'package:final_project_shopping_app/utils/theme/outlined_button_theme.dart';
import 'package:final_project_shopping_app/utils/theme/text_field_theme.dart';
import 'package:final_project_shopping_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'DMSans',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    drawerTheme: TDrawerTheme.lightDrawerTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomBarTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButton,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'DMSans',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomBarTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButton,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
