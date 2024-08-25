import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: TColors.primaryColor,
    checkmarkColor: TColors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: TColors.darkerGrey,
    labelStyle: TextStyle(color: Colors.black),
    selectedColor: TColors.primaryColor,
    checkmarkColor: TColors.white,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
  );
}
