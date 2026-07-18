import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../theme/animation.dart';
import '../../theme/border.dart';
import '../../theme/spacing.dart';

class SilkCameraControl extends StatelessWidget {
  final bool flashEnabled;
  final bool isSwitching;
  final VoidCallback? onFlashToggle;
  final VoidCallback? onCapture;
  final VoidCallback? onSwitchCamera;
  final VoidCallback? onGallery;

  const SilkCameraControl({
    super.key,
    this.flashEnabled = false,
    this.isSwitching = false,
    this.onFlashToggle,
    this.onCapture,
    this.onSwitchCamera,
    this.onGallery,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: topPadding + SilkSpacing.s2,
            right: SilkSpacing.s4,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: _CircleButton(
              icon: flashEnabled
                  ? Icons.flash_on_rounded
                  : Icons.flash_off_rounded,
              onPressed: onFlashToggle,
              active: flashEnabled,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SilkSpacing.s5,
            0,
            SilkSpacing.s5,
            SilkSpacing.s5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _GalleryButton(onTap: onGallery),
              _CaptureButton(onTap: onCapture, isSwitching: isSwitching),
              _CircleButton(
                icon: Icons.cameraswitch_rounded,
                onPressed: onSwitchCamera,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CircleButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool active;

  const _CircleButton({
    required this.icon,
    this.onPressed,
    this.active = false,
  });

  @override
  State<_CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<_CircleButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: SilkAnimation.fast,
    );
    _scaleAnim = Tween(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _scaleController, curve: SilkAnimation.spring),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) {
        _scaleController.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _scaleController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: SilkAnimation.duration,
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withValues(alpha: 0.35),
            border: widget.active
                ? Border.all(
                    color: Colors.white.withValues(alpha: 0.8),
                    width: 1.5,
                  )
                : null,
          ),
          child: Icon(widget.icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _CaptureButton extends StatefulWidget {
  final VoidCallback? onTap;
  final bool isSwitching;

  const _CaptureButton({this.onTap, this.isSwitching = false});

  @override
  State<_CaptureButton> createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<_CaptureButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnim = Tween(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: ScaleTransition(
        scale: _pulseAnim,
        child: AnimatedContainer(
          duration: SilkAnimation.fast,
          curve: SilkAnimation.spring,
          width: _pressed ? 62 : 72,
          height: _pressed ? 62 : 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: AnimatedSwitcher(
            duration: SilkAnimation.duration,
            child: widget.isSwitching
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _GalleryButton extends StatefulWidget {
  final VoidCallback? onTap;

  const _GalleryButton({this.onTap});

  @override
  State<_GalleryButton> createState() => _GalleryButtonState();
}

class _GalleryButtonState extends State<_GalleryButton>
    with SingleTickerProviderStateMixin {
  Uint8List? _thumbBytes;
  bool _disposed = false;
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: SilkAnimation.fast,
    );
    _scaleAnim = Tween(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _scaleController, curve: SilkAnimation.spring),
    );
    _loadLatestThumb();
  }

  @override
  void dispose() {
    _disposed = true;
    _scaleController.dispose();
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
    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) {
        _scaleController.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _scaleController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SilkBorder.radiusMd),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.5,
            ),
            image: _thumbBytes != null
                ? DecorationImage(
                    image: MemoryImage(_thumbBytes!),
                    fit: BoxFit.cover,
                  )
                : null,
            color: Colors.black.withValues(alpha: 0.3),
          ),
          child: _thumbBytes == null
              ? const Icon(
                  Icons.photo_library_rounded,
                  color: Colors.white,
                  size: 22,
                )
              : null,
        ),
      ),
    );
  }
}
