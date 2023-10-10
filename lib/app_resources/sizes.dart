import 'package:flutter/material.dart';

class Sizes {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width / 414;
    screenHeight = _mediaQueryData!.size.height / 988;
  }
}

extension SizerExt on num {
  double get h => this * Sizes.screenHeight!;
  double get w => this * Sizes.screenWidth!;
}