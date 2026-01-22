import 'package:flutter/material.dart';

double responsiveFontSize(BuildContext context, {required double fontSize}) {
  final double scaleFactor = _getResponsiveScaleFactor(context);

  final double scaledFontSize = fontSize * scaleFactor;

  final double minFontSize = fontSize * 0.9;
  final double maxFontSize = fontSize * 1.3;

  return scaledFontSize.clamp(minFontSize, maxFontSize);
}

double _getResponsiveScaleFactor(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth < 600) {
    return screenWidth / 315;
  } else if (screenWidth < 900) {
    return screenWidth / 768;
  } else {
    return screenWidth / 1200;
  }
}
