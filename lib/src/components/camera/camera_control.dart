import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../theme/colors.dart';
import '../../theme/gap.dart';
import '../../theme/spacing.dart';
import '../button/button.dart';
import '../button/icon_button.dart';
import '../button/img_button.dart';

class CameraControlMetrics {
  static const double captureOuterSize = SilkSpacing.iconButtonSideLg + SilkGap.lg;
  static const double captureInnerSize = SilkSpacing.iconButtonSideLg + SilkGap.sm;
  static const double captureBorderWidth = SilkGap.xs;
  static const double edgePadding = SilkGap.lg * 1.5;
  static const double controlGap = SilkGap.lg * 1.5;
}

class SilkCameraControl extends StatelessWidget {
  final bool flashEnabled;
  final VoidCallback? onFlashToggle;
  final VoidCallback? onCapture;
  final VoidCallback? onSwitchCamera;
  final VoidCallback? onGallery;
  final Uint8List? galleryThumbBytes;

  const SilkCameraControl({
    super.key,
    this.flashEnabled = false,
    this.onFlashToggle,
    this.onCapture,
    this.onSwitchCamera,
    this.onGallery,
    this.galleryThumbBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: CameraControlMetrics.edgePadding,
          left: 0,
          right: 0,
          child: Center(
            child: SilkIconButton(
              icon: flashEnabled
                  ? PhosphorIcons.lightning()
                  : PhosphorIcons.lightningSlash(),
              iconColor: SilkColors.light,
              variant: ButtonVariant.alt,
              scale: ButtonScale.sm,
              onPressed: onFlashToggle,
            ),
          ),
        ),
        Positioned(
          bottom: CameraControlMetrics.edgePadding,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SilkImgButton(
                icon: PhosphorIcons.images(),
                imgBytes: galleryThumbBytes,
                iconColor: SilkColors.light,
                variant: ButtonVariant.alt,
                scale: ButtonScale.lg,
                onPressed: onGallery,
              ),
              const SizedBox(width: CameraControlMetrics.controlGap),
              _CaptureButton(onTap: onCapture),
              const SizedBox(width: CameraControlMetrics.controlGap),
              SilkIconButton(
                icon: PhosphorIcons.arrowsCounterClockwise(),
                iconColor: SilkColors.light,
                variant: ButtonVariant.alt,
                scale: ButtonScale.lg,
                onPressed: onSwitchCamera,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CaptureButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _CaptureButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: CameraControlMetrics.captureOuterSize,
        height: CameraControlMetrics.captureOuterSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: SilkColors.light,
            width: CameraControlMetrics.captureBorderWidth,
          ),
        ),
        child: Center(
          child: Container(
            width: CameraControlMetrics.captureInnerSize,
            height: CameraControlMetrics.captureInnerSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
