import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../theme/border.dart';
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
            child: SilkIconButton(
              icon: flashEnabled
                  ? PhosphorIcons.lightning()
                  : PhosphorIcons.lightningSlash(),
              iconColor: SilkColors.light,
              variant: ButtonVariant.alt,
              scale: ButtonScale.md,
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
              _GalleryImgButton(onTap: onGallery),
              const SizedBox(width: CameraControlMetrics.controlGap),
              _CaptureButton(onTap: onCapture),
              const SizedBox(width: CameraControlMetrics.controlGap),
              SilkIconButton(
                icon: PhosphorIcons.arrowsCounterClockwise(),
                iconColor: SilkColors.light,
                variant: ButtonVariant.alt,
                scale: ButtonScale.md,
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

class _GalleryImgButton extends StatefulWidget {
  final VoidCallback? onTap;

  const _GalleryImgButton({this.onTap});

  @override
  State<_GalleryImgButton> createState() => _GalleryImgButtonState();
}

class _GalleryImgButtonState extends State<_GalleryImgButton> {
  Uint8List? _thumbBytes;
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
      final permission = await PhotoManager.requestPermissionExtend();
      if (!permission.hasAccess || _disposed) return;

      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );
      if (albums.isEmpty || _disposed) return;

      final assets = await albums.first.getAssetListRange(start: 0, end: 1);
      if (assets.isEmpty || _disposed) return;

      final bytes = await assets.first.thumbnailDataWithSize(
        const ThumbnailSize.square(256),
      );
      if (_disposed || !mounted) return;
      setState(() => _thumbBytes = bytes);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return SilkImgButton(
      icon: PhosphorIcons.images(),
      iconColor: SilkColors.light,
      imgBytes: _thumbBytes,
      variant: ButtonVariant.alt,
      scale: ButtonScale.sm,
      onPressed: widget.onTap,
      borderRadius: SilkBorder.radiusLg,
    );
  }
}
