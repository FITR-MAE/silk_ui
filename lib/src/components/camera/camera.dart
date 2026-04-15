import 'dart:async';

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

  int _openRequestId = 0;
  Timer? _openDebounce;

  static const Duration _openDebounceDelay = Duration(milliseconds: 250);
  static const Duration _disposeDelay = Duration(milliseconds: 150);

  bool get _shouldHoldCamera => widget.isActive && _isForeground;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _syncCameraState();
  }

  @override
  void didUpdateWidget(covariant SilkCamera oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isActive != widget.isActive ||
        oldWidget.sensorPosition != widget.sensorPosition) {
      _syncCameraState(
        forceReinitialize: oldWidget.sensorPosition != widget.sensorPosition,
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isDisposed) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _isForeground = true;
        _syncCameraState();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _isForeground = false;
        _syncCameraState();
        break;
    }
  }

  void _syncCameraState({bool forceReinitialize = false}) {
    _openDebounce?.cancel();

    if (!_shouldHoldCamera) {
      unawaited(_closeCamera());
      return;
    }

    _openDebounce = Timer(_openDebounceDelay, () {
      _openCamera(forceReinitialize: forceReinitialize);
    });
  }

  Future<void> _openCamera({bool forceReinitialize = false}) async {
    if (_isDisposed || !mounted || !_shouldHoldCamera) return;
    if (_isInitializing) return;

    if (!forceReinitialize &&
        _controller != null &&
        _controller!.value.isInitialized) {
      return;
    }

    final int requestId = ++_openRequestId;
    _isInitializing = true;

    if (mounted) {
      setState(() {
        _hasError = false;
        _isInitialized = false;
      });
    }

    try {
      await _disposeController();
      await Future.delayed(_disposeDelay);

      if (!_isOpenRequestValid(requestId)) return;

      final cameras = await (widget.availableCamerasLoader ?? availableCameras)();

      if (!_isOpenRequestValid(requestId)) return;

      if (cameras.isEmpty) {
        if (mounted) {
          setState(() {
            _hasError = true;
            _isInitialized = false;
          });
        }
        return;
      }

      final desiredLensDirection = widget.sensorPosition == SensorPosition.back
          ? CameraLensDirection.back
          : CameraLensDirection.front;

      final camera = cameras.firstWhere(
        (c) => c.lensDirection == desiredLensDirection,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        camera,
        ResolutionPreset.low,
        enableAudio: false,
      );

      _controller = controller;

      await controller.initialize();

      if (!_isOpenRequestValid(requestId)) {
        await controller.dispose();
        return;
      }

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _hasError = false;
        });
      }
    } on CameraException {
      if (_isOpenRequestValid(requestId) && mounted) {
        setState(() {
          _hasError = true;
          _isInitialized = false;
        });
      }
      await _disposeController();
    } catch (_) {
      if (_isOpenRequestValid(requestId) && mounted) {
        setState(() {
          _hasError = true;
          _isInitialized = false;
        });
      }
      await _disposeController();
    } finally {
      if (_isOpenRequestValid(requestId)) {
        _isInitializing = false;
      }
    }
  }

  bool _isOpenRequestValid(int requestId) {
    return !_isDisposed &&
        mounted &&
        _shouldHoldCamera &&
        requestId == _openRequestId;
  }

  Future<void> _closeCamera() async {
    _openRequestId++;
    _isInitializing = false;
    await _disposeController();

    if (!mounted || _isDisposed) return;

    setState(() {
      _isInitialized = false;
    });
  }

  Future<void> _disposeController() async {
    final controller = _controller;
    _controller = null;

    if (controller != null) {
      try {
        await controller.dispose();
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isDisposed = true;
    _openDebounce?.cancel();
    _openRequestId++;
    unawaited(_disposeController());
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
    final preview = CameraPreview(controller);
    final previewSize = controller.value.previewSize;

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
