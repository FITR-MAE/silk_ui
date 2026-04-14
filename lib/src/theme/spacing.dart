import 'package:flutter/material.dart';

enum ButtonSize { sm, md, lg }

enum ButtonVariant { primary, secondary, alt }

class ButtonSpacing {
  static const double borderRadius = 12.0;
  static const double borderWidth = 2.0;
  static const BorderStyle borderStyle = BorderStyle.solid;
  static const Duration animationDuration = Duration(milliseconds: 150);

  static const double paddingVerticalSm = 8.0;
  static const double paddingHorizontalSm = 16.0;
  static const double paddingVerticalMd = 12.0;
  static const double paddingHorizontalMd = 24.0;
  static const double paddingVerticalLg = 16.0;
  static const double paddingHorizontalLg = 32.0;

  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;

  static const double iconSizeSm = 20.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 28.0;

  static const double containerSizeSm = 36.0;
  static const double containerSizeMd = 48.0;
  static const double containerSizeLg = 56.0;

  static const double iconButtonSizeSm = 36.0;
  static const double iconButtonSizeMd = 48.0;
  static const double iconButtonSizeLg = 56.0;
}

enum SilkTextSize { sm, md, lg }

enum SilkTitleLevel { h1, h2, h3 }

class TypographySpacing {
  static const double titleH1 = 32.0;
  static const double titleH2 = 24.0;
  static const double titleH3 = 20.0;

  static const double textSm = 12.0;
  static const double textMd = 16.0;
  static const double textLg = 20.0;

  static const Color textColorSm = Color(0xFF757575);
  static const Color textColorMd = Color(0xFF000000);
  static const Color textColorLg = Color(0xFF000000);
}

class CardSpacing {
  static const double defaultElevation = 2.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultPadding = 16.0;
}
