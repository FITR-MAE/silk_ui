import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/gap.dart';

typedef AvailableCamerasLoader = Future<List<CameraDescription>> Function();

class CameraGap {
  static const double progressStrokeWidth = SilkBorder.width * 5;
  static const double fallbackIconSize = SilkGap.lg * 2;
}

class SilkCamera extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;
  final CameraLensDirection lensDirection;
  final Widget? placeholder;
  final Widget? errorWidget;
  final VoidCallback? onInitialized;
  final ValueChanged<Object>? onError;
  final CameraController? controller;
  final AvailableCamerasLoader? availableCamerasLoader;

  const SilkCamera({
    super.key,
    this.width,
    this.height,
    this.borderRadius = SilkBorder.radiusMd,
    this.fit = BoxFit.cover,
    this.lensDirection = CameraLensDirection.back,
    this.placeholder,
    this.errorWidget,
    this.onInitialized,
    this.onError,
    this.controller,
    this.availableCamerasLoader,
  });

  @override
  State<SilkCamera> createState() => _SilkCameraState();
}

class _SilkCameraState extends State<SilkCamera> {
  CameraController? _controller;
  Object? _error;
  bool _ownsController = false;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller?.dispose();
    }
    super.dispose();
  }

  Future<void> _initialize() async {
    try {
      final controller = widget.controller ?? await _createController();
      if (controller == null) {
        throw StateError('No camera available');
      }

      if (!controller.value.isInitialized) {
        await controller.initialize();
      }

      if (!mounted) {
        if (_ownsController) {
          await controller.dispose();
        }
        return;
      }

      setState(() {
        _controller = controller;
        _error = null;
        _isInitializing = false;
      });
      widget.onInitialized?.call();
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = error;
        _isInitializing = false;
      });
      widget.onError?.call(error);
    }
  }

  Future<CameraController?> _createController() async {
    final loader = widget.availableCamerasLoader ?? availableCameras;
    final cameras = await loader();
    final camera = cameras.cast<CameraDescription?>().firstWhere(
      (camera) => camera?.lensDirection == widget.lensDirection,
      orElse: () => cameras.isEmpty ? null : cameras.first,
    );

    if (camera == null) {
      return null;
    }

    _ownsController = true;
    return CameraController(camera, ResolutionPreset.medium);
  }

  @override
  Widget build(BuildContext context) {
    final child = _buildChild(context);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: child,
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (_error != null) {
      return widget.errorWidget ?? _fallbackState(Icons.videocam_off);
    }

    if (_isInitializing ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return widget.placeholder ??
          const ColoredBox(
            color: SilkColors.dark,
            child: Center(
              child: SizedBox(
                width: SilkGap.lg * 2,
                height: SilkGap.lg * 2,
                child: CircularProgressIndicator(
                  strokeWidth: CameraGap.progressStrokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(SilkColors.light),
                ),
              ),
            ),
          );
    }

    final preview = CameraPreview(_controller!);
    final previewSize = _controller!.value.previewSize;

    if (previewSize == null) {
      return preview;
    }

    return FittedBox(
      fit: widget.fit,
      child: SizedBox(
        width: previewSize.height,
        height: previewSize.width,
        child: preview,
      ),
    );
  }

  Widget _fallbackState(IconData icon) {
    return ColoredBox(
      color: SilkColors.dark,
      child: Center(
        child: Icon(
          icon,
          size: CameraGap.fallbackIconSize,
          color: SilkColors.light,
        ),
      ),
    );
  }
}
