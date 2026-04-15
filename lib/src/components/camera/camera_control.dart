import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../theme/animation.dart';
import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/gap.dart';
import '../../theme/spacing.dart';
import '../button/button.dart';
import '../button/icon_button.dart';

class CameraControlMetrics {
  static const double captureOuterSize =
      SilkSpacing.iconButtonSideLg + SilkGap.lg;
  static const double captureInnerSize =
      SilkSpacing.iconButtonSideLg + SilkGap.sm;
  static const double captureBorderWidth = SilkGap.xs;
  static const double flashButtonSize = SilkSpacing.iconButtonSideSm;
  static const double flashIconSize = SilkSpacing.iconButtonIconMd;
  static const double edgePadding = SilkGap.lg * 1.5;
  static const double controlGap = SilkGap.lg * 1.5;
}

class SilkCameraControl extends StatelessWidget {
  final bool flashEnabled;
  final VoidCallback? onFlashToggle;
  final VoidCallback? onCapture;
  final VoidCallback? onSwitchCamera;
  final VoidCallback? onGallery;

  const SilkCameraControl({
    super.key,
    this.flashEnabled = false,
    this.onFlashToggle,
    this.onCapture,
    this.onSwitchCamera,
    this.onGallery,
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
            child: _FlashButton(enabled: flashEnabled, onTap: onFlashToggle),
          ),
        ),
        Positioned(
          bottom: CameraControlMetrics.edgePadding,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _GalleryImgButton(onTap: onGallery),
              const SizedBox(width: CameraControlMetrics.controlGap),
              _CaptureButton(onTap: onCapture),
              const SizedBox(width: CameraControlMetrics.controlGap),
              _SwitchCameraButton(onTap: onSwitchCamera),
            ],
          ),
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

class _SwitchCameraButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _SwitchCameraButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return SilkIconButton(
      icon: PhosphorIcons.arrowsCounterClockwise(),
      iconColor: SilkColors.light,
      variant: ButtonVariant.alt,
      scale: ButtonScale.sm,
      backgroundColor: SilkColors.dark.withValues(alpha: 0.35),
      onPressed: onTap,
    );
  }
}

class _GalleryImgButton extends StatefulWidget {
  final VoidCallback? onTap;

  const _GalleryImgButton({this.onTap});

  @override
  State<_GalleryImgButton> createState() => _GalleryImgButtonState();
}

class _GalleryImgButtonState extends State<_GalleryImgButton> {
  Future<Uint8List?>? _thumbFuture;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _loadLatestThumb();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> _loadLatestThumb() async {
    try {
      final auth = await PhotoManager.requestPermissionExtend();
      if (!auth.hasAccess) return;

      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );
      if (albums.isEmpty) return;

      final assets = await albums.first.getAssetListRange(start: 0, end: 1);
      if (assets.isEmpty) return;

      final future = assets.first.thumbnailDataWithSize(
        const ThumbnailSize.square(128),
      );
      if (_disposed) return;
      setState(() => _thumbFuture = future);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final thumbSize = SilkSpacing.iconButtonSideSm;

    return AnimatedOpacity(
      duration: SilkAnimation.duration,
      opacity: 1.0,
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        shadowColor: const Color(0x1A000000),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(SilkBorder.radiusRound),
          child: Container(
            width: thumbSize,
            height: thumbSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SilkBorder.radiusRound),
              color: SilkColors.dark.withValues(alpha: 0.35),
            ),
            child: ClipOval(
              child: FutureBuilder<Uint8List?>(
                future: _thumbFuture,
                builder: (context, snapshot) {
                  final bytes = snapshot.data;
                  if (bytes == null) {
                    return Center(
                      child: Icon(
                        PhosphorIcons.images(),
                        color: SilkColors.light,
                        size: 24,
                      ),
                    );
                  }
                  return Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  );
                },
              ),
            ),
          ),
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
