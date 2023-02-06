import 'package:flutter/material.dart';
import 'package:flutter_rewind/colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.themeBackGround,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.themeBackGround,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.black87),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Colors.black54),
    sliderTheme: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
  );
}
