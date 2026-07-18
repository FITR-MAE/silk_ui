import 'package:flutter/material.dart';

import 'text.dart';
import '../../theme/typography.dart';
import 'title.dart';

class TextGap {
  static double fontSize(TextScale scale) {
    switch (scale) {
      case TextScale.xs:
        return SilkTypography.xs;
      case TextScale.sm:
        return SilkTypography.sm;
      case TextScale.md:
        return SilkTypography.md;
      case TextScale.lg:
        return SilkTypography.lg;
    }
  }

  static FontWeight weight(TextScale scale) {
    switch (scale) {
      case TextScale.xs:
      case TextScale.sm:
        return SilkTypography.normal;
      case TextScale.md:
      case TextScale.lg:
        return SilkTypography.normal;
    }
  }

  static double lineHeight(TextScale scale) {
    switch (scale) {
      case TextScale.xs:
      case TextScale.sm:
        return SilkTypography.normalLine;
      case TextScale.md:
      case TextScale.lg:
        return SilkTypography.relaxed;
    }
  }
}

class TitleGap {
  static double fontSize(TitleScale scale) {
    switch (scale) {
      case TitleScale.h1:
        return SilkTypography.xxxl;
      case TitleScale.h2:
        return SilkTypography.xxl;
      case TitleScale.h3:
        return SilkTypography.xl;
    }
  }

  static FontWeight weight(TitleScale scale) {
    switch (scale) {
      case TitleScale.h1:
        return SilkTypography.bold;
      case TitleScale.h2:
        return SilkTypography.semibold;
      case TitleScale.h3:
        return SilkTypography.semibold;
    }
  }

  static double letterSpacing(TitleScale scale) {
    switch (scale) {
      case TitleScale.h1:
        return SilkTypography.trackingTight;
      case TitleScale.h2:
      case TitleScale.h3:
        return SilkTypography.trackingNormal;
    }
  }
}
