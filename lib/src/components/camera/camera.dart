import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/gap.dart';

class CameraGap {
  static const double progressStrokeWidth = SilkBorder.width * 5;
  static const double fallbackIconSize = SilkGap.lg * 2;
}

class SilkCamera extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final CameraPreviewFit fit;
  final SensorPosition sensorPosition;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Future<List<CameraDescription>> Function()? availableCamerasLoader;

  /// Whether this camera should actively hold the device camera.
  /// When false, the controller is disposed but the widget stays mounted.
  final bool isActive;

  const SilkCamera({
    super.key,
    this.width,
    this.height,
    this.borderRadius = SilkBorder.radiusNone,
    this.fit = CameraPreviewFit.cover,
    this.sensorPosition = SensorPosition.back,
    this.placeholder,
    this.errorWidget,
    this.availableCamerasLoader,
    this.isActive = true,
  });

  @override
  State<SilkCamera> createState() => _SilkCameraState();
}

class _SilkCameraState extends State<SilkCamera> with WidgetsBindingObserver {
  CameraController? _controller;

  bool _isInitialized = false;
  bool _hasError = false;
  bool _isInitializing = false;
  bool _isDisposed = false;
  bool _isForeground = true;

  int _sessionId = 0;
  int _retryCount = 0;

  static const int _maxRetryCount = 3;
  static const Duration _disposeDelay = Duration(milliseconds: 200);
  static const Duration _reopenDelay = Duration(milliseconds: 300);

  bool get _shouldHoldCamera => widget.isActive && _isForeground;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (_shouldHoldCamera) {
      _initCamera();
    }
  }

  @override
  void didUpdateWidget(covariant SilkCamera oldWidget) {
    super.didUpdateWidget(oldWidget);

    final sensorChanged = oldWidget.sensorPosition != widget.sensorPosition;
    final activeChanged = oldWidget.isActive != widget.isActive;

    if (sensorChanged) {
      if (_shouldHoldCamera) {
        _initCamera(forceReinitialize: true);
      } else {
        _pauseCamera();
      }
      return;
    }

    if (activeChanged) {
      if (_shouldHoldCamera) {
        _initCamera(forceReinitialize: true);
      } else {
        _pauseCamera();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isDisposed) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _isForeground = true;
        if (_shouldHoldCamera) {
          _initCamera(forceReinitialize: true);
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _isForeground = false;
        _pauseCamera();
        break;
    }
  }

  Future<void> _pauseCamera() async {
    _sessionId++;
    _retryCount = 0;
    _isInitializing = false;

    await _disposeController();

    if (!mounted || _isDisposed) return;

    setState(() {
      _isInitialized = false;
    });
  }

  Future<void> _initCamera({bool forceReinitialize = false}) async {
    if (_isDisposed || !mounted) return;
    if (!_shouldHoldCamera) return;
    if (_isInitializing) return;

    if (!forceReinitialize &&
        _controller != null &&
        _controller!.value.isInitialized) {
      return;
    }

    _isInitializing = true;
    final int sessionId = ++_sessionId;

    if (mounted) {
      setState(() {
        _hasError = false;
        _isInitialized = false;
      });
    }

    try {
      await _disposeController();
      await Future.delayed(_disposeDelay);

      if (_isDisposed ||
          !mounted ||
          sessionId != _sessionId ||
          !_shouldHoldCamera) {
        return;
      }

      final cameras = await (widget.availableCamerasLoader ?? availableCameras)();

      if (_isDisposed ||
          !mounted ||
          sessionId != _sessionId ||
          !_shouldHoldCamera) {
        return;
      }

      if (cameras.isEmpty) {
        setState(() {
          _hasError = true;
          _isInitialized = false;
        });
        return;
      }

      final desiredLensDirection = widget.sensorPosition == SensorPosition.back
          ? CameraLensDirection.back
          : CameraLensDirection.front;

      final camera = cameras.firstWhere(
        (c) => c.lensDirection == desiredLensDirection,
        orElse: () => cameras.first,
      );

      await Future.delayed(_reopenDelay);

      if (_isDisposed ||
          !mounted ||
          sessionId != _sessionId ||
          !_shouldHoldCamera) {
        return;
      }

      final controller = CameraController(
        camera,
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      _controller = controller;

      await controller.initialize();

      if (_isDisposed ||
          !mounted ||
          sessionId != _sessionId ||
          !_shouldHoldCamera) {
        await controller.dispose();
        return;
      }

      _retryCount = 0;

      setState(() {
        _isInitialized = true;
        _hasError = false;
      });
    } catch (_) {
      if (_isDisposed || !mounted || sessionId != _sessionId) return;

      await _disposeController();

      if (_shouldHoldCamera && _retryCount < _maxRetryCount) {
        _retryCount++;
        _isInitializing = false;

        await Future.delayed(Duration(milliseconds: 400 * _retryCount));

        if (_isDisposed ||
            !mounted ||
            sessionId != _sessionId ||
            !_shouldHoldCamera) {
          return;
        }

        return _initCamera(forceReinitialize: true);
      }

      setState(() {
        _hasError = true;
        _isInitialized = false;
      });
    } finally {
      if (!_isDisposed && sessionId == _sessionId) {
        _isInitializing = false;
      }
    }
  }

  Future<void> _disposeController() async {
    final controller = _controller;
    _controller = null;

    if (controller != null) {
      try {
        await controller.dispose();
      } catch (_) {
        // Ignore disposal errors on unstable devices.
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isDisposed = true;
    _sessionId++;
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSize = widget.width != null || widget.height != null;

    Widget content;
    if (_hasError) {
      content = widget.errorWidget ?? _errorPlaceholder();
    } else if (!_isInitialized || _controller == null) {
      content = widget.placeholder ?? _loadingPlaceholder();
    } else {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: _buildPreview(),
      );
    }

    return hasSize
        ? SizedBox(width: widget.width, height: widget.height, child: content)
        : SizedBox.expand(child: content);
  }

  Widget _buildPreview() {
    final controller = _controller!;
    final previewSize = controller.value.previewSize;
    final preview = CameraPreview(controller);

    if (widget.fit == CameraPreviewFit.fill || previewSize == null) {
      return SizedBox.expand(child: preview);
    }

    return FittedBox(
      fit: _toBoxFit(widget.fit),
      child: SizedBox(
        width: previewSize.height,
        height: previewSize.width,
        child: preview,
      ),
    );
  }

  BoxFit _toBoxFit(CameraPreviewFit fit) {
    switch (fit) {
      case CameraPreviewFit.cover:
        return BoxFit.cover;
      case CameraPreviewFit.contain:
        return BoxFit.contain;
      case CameraPreviewFit.fill:
        return BoxFit.fill;
      case CameraPreviewFit.fitWidth:
        return BoxFit.fitWidth;
      case CameraPreviewFit.fitHeight:
        return BoxFit.fitHeight;
    }
  }

  Widget _loadingPlaceholder() {
    return ColoredBox(
      color: SilkColors.dark,
      child: const Center(
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

  Widget _errorPlaceholder() {
    return const ColoredBox(
      color: SilkColors.dark,
      child: Center(
        child: SizedBox(
          width: SilkGap.lg * 2,
          height: SilkGap.lg * 2,
          child: Icon(
            Icons.camera_alt_outlined,
            color: SilkColors.light,
            size: CameraGap.fallbackIconSize,
          ),
        ),
      ),
    );
  }
}

enum SensorPosition { back, front }

enum CameraPreviewFit { cover, contain, fill, fitWidth, fitHeight }
