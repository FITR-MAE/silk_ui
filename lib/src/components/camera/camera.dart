import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/gap.dart';
import 'camera_control.dart';
import 'camera_viewfinder.dart';

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
  final bool showControls;
  final void Function(XFile file)? onCapture;

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
    this.showControls = true,
    this.onCapture,
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
  final ValueNotifier<bool> _flashEnabled = ValueNotifier<bool>(false);
  bool _isCapturing = false;

  int _openRequestId = 0;
  Timer? _openDebounce;

  late SensorPosition _sensorPosition = widget.sensorPosition;

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

    final sensorChanged = oldWidget.sensorPosition != widget.sensorPosition;
    if (sensorChanged) {
      _sensorPosition = widget.sensorPosition;
    }

    if (oldWidget.isActive != widget.isActive || sensorChanged) {
      _syncCameraState(forceReinitialize: sensorChanged);
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

      final desiredLensDirection = _sensorPosition == SensorPosition.back
          ? CameraLensDirection.back
          : CameraLensDirection.front;

      final camera = cameras.firstWhere(
        (c) => c.lensDirection == desiredLensDirection,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      _controller = controller;

      await controller.initialize();
      await _applyFlashMode(controller);

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

  Future<void> _applyFlashMode(CameraController controller) async {
    if (!_flashEnabled.value) return;
    try {
      await controller.setFlashMode(FlashMode.always);
    } catch (_) {}
  }

  Future<void> _toggleFlash() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    final next = !_flashEnabled.value;
    _flashEnabled.value = next;

    try {
      await controller.setFlashMode(next ? FlashMode.always : FlashMode.off);
    } catch (_) {
      _flashEnabled.value = !next;
    }
  }

  void _switchCamera() {
    if (_isDisposed || !mounted || _isInitializing) return;
    _flashEnabled.value = false;
    setState(() {
      _sensorPosition = _sensorPosition == SensorPosition.back
          ? SensorPosition.front
          : SensorPosition.back;
      _isInitialized = false;
    });
    _syncCameraState(forceReinitialize: true);
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (_isCapturing ||
        controller == null ||
        !controller.value.isInitialized ||
        controller.value.isTakingPicture) {
      return;
    }

    _isCapturing = true;
    try {
      final file = await controller.takePicture();
      widget.onCapture?.call(file);
    } catch (_) {
    } finally {
      _isCapturing = false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isDisposed = true;
    _openDebounce?.cancel();
    _openRequestId++;
    _flashEnabled.dispose();
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
        child: ColoredBox(
          color: SilkColors.dark,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SilkCameraViewfinder(controller: _controller!, fit: widget.fit),
              if (widget.showControls)
                RepaintBoundary(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _flashEnabled,
                    builder: (_, flashEnabled, _) => SilkCameraControl(
                      flashEnabled: flashEnabled,
                      onFlashToggle: _toggleFlash,
                      onCapture: _capture,
                      onSwitchCamera: _switchCamera,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return hasSize
        ? SizedBox(width: widget.width, height: widget.height, child: content)
        : SizedBox.expand(child: content);
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
