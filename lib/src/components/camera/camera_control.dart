import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/gap.dart';

class CameraControlMetrics {
  static const double captureOuterSize = 72.0;
  static const double captureInnerSize = 60.0;
  static const double captureBorderWidth = 4.0;
  static const double flashButtonSize = 40.0;
  static const double flashIconSize = 24.0;
  static const double edgePadding = SilkGap.lg * 1.5;
}

class SilkCameraControl extends StatelessWidget {
  final bool flashEnabled;
  final VoidCallback? onFlashToggle;
  final VoidCallback? onCapture;

  const SilkCameraControl({
    super.key,
    this.flashEnabled = false,
    this.onFlashToggle,
    this.onCapture,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: CameraControlMetrics.edgePadding,
          left: 0,
          right: 0,
          child: Center(child: _FlashButton(
            enabled: flashEnabled,
            onTap: onFlashToggle,
          )),
        ),
        Positioned(
          bottom: CameraControlMetrics.edgePadding,
          left: 0,
          right: 0,
          child: Center(child: _CaptureButton(onTap: onCapture)),
        ),
      ],
    );
  }
}

class _FlashButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onTap;

  const _FlashButton({required this.enabled, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: CameraControlMetrics.flashButtonSize,
        height: CameraControlMetrics.flashButtonSize,
        decoration: BoxDecoration(
          color: SilkColors.dark.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(SilkBorder.radiusRound),
        ),
        child: Icon(
          enabled ? Icons.flash_on : Icons.flash_off,
          color: SilkColors.light,
          size: CameraControlMetrics.flashIconSize,
        ),
      ),
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
