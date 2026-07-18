import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../theme/animation.dart';
import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/gap.dart';
import 'camera_control.dart';
import 'camera_viewfinder.dart';

class _CameraGap {
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
  final VoidCallback? onGallery;
  final VoidCallback? onClose;

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
    this.onGallery,
    this.onClose,
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
  bool _isSwitchingCameras = false;

  int _openRequestId = 0;
  Timer? _openDebounce;
  Future<void> _transition = Future<void>.value();

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
    final requestId = ++_openRequestId;

    if (!_shouldHoldCamera) {
      _transition = _transition.then((_) => _closeCamera(requestId));
      return;
    }

    _openDebounce = Timer(_openDebounceDelay, () {
      _transition = _transition.then(
        (_) => _openCamera(
          requestId: requestId,
          forceReinitialize: forceReinitialize,
        ),
      );
    });
  }

  Future<void> _openCamera({
    required int requestId,
    bool forceReinitialize = false,
  }) async {
    if (!_isOpenRequestValid(requestId)) return;

    if (!forceReinitialize &&
        _controller != null &&
        _controller!.value.isInitialized) {
      return;
    }

    _isInitializing = true;

    if (mounted) {
      setState(() {
        _hasError = false;
        _isInitialized = false;
      });
    }

    CameraController? openingController;
    try {
      await _disposeController();
      await Future.delayed(_disposeDelay);

      if (!_isOpenRequestValid(requestId)) return;

      final cameras =
          await (widget.availableCamerasLoader ?? availableCameras)();

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

      openingController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      await openingController.initialize();
      await _applyFlashMode(openingController);

      if (!_isOpenRequestValid(requestId)) {
        await openingController.dispose();
        return;
      }

      _controller = openingController;
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _hasError = false;
          _isSwitchingCameras = false;
        });
      }
    } on CameraException {
      if (_isOpenRequestValid(requestId) && mounted) {
        setState(() {
          _hasError = true;
          _isInitialized = false;
        });
      }
      await _disposeControllerInstance(openingController);
    } catch (_) {
      if (_isOpenRequestValid(requestId) && mounted) {
        setState(() {
          _hasError = true;
          _isInitialized = false;
        });
      }
      await _disposeControllerInstance(openingController);
    } finally {
      _isInitializing = false;
    }
  }

  bool _isOpenRequestValid(int requestId) {
    return !_isDisposed &&
        mounted &&
        _shouldHoldCamera &&
        requestId == _openRequestId;
  }

  Future<void> _closeCamera(int requestId) async {
    if (requestId != _openRequestId) return;
    await _disposeController();

    if (!mounted || _isDisposed || requestId != _openRequestId) return;

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

  Future<void> _disposeControllerInstance(CameraController? controller) async {
    if (controller == null) return;
    if (identical(_controller, controller)) _controller = null;
    try {
      await controller.dispose();
    } catch (_) {}
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
      if (!_isDisposed) _flashEnabled.value = !next;
    }
  }

  void _switchCamera() {
    if (_isDisposed || !mounted || _isInitializing || _isSwitchingCameras) {
      return;
    }
    _flashEnabled.value = false;
    setState(() {
      _sensorPosition = _sensorPosition == SensorPosition.back
          ? SensorPosition.front
          : SensorPosition.back;
      _isSwitchingCameras = true;
    });
    _syncCameraState(forceReinitialize: true);
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (_isCapturing ||
        _isSwitchingCameras ||
        controller == null ||
        !controller.value.isInitialized ||
        controller.value.isTakingPicture) {
      return;
    }

    _isCapturing = true;
    try {
      final file = await controller.takePicture();
      widget.onCapture?.call(file);
      unawaited(_saveToCameraRoll(file));
    } catch (_) {
    } finally {
      _isCapturing = false;
    }
  }

  Future<void> _saveToCameraRoll(XFile file) async {
    try {
      final permission = await PhotoManager.requestPermissionExtend();
      if (!permission.hasAccess) return;

      final bytes = await File(file.path).readAsBytes();
      await PhotoManager.editor.saveImage(
        bytes,
        filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
    } catch (_) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isDisposed = true;
    _openDebounce?.cancel();
    _openRequestId++;
    _flashEnabled.dispose();
    unawaited(_transition.then((_) => _disposeController()));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSize = widget.width != null || widget.height != null;

    Widget content;
    if (_hasError) {
      content = widget.errorWidget ?? _errorPlaceholder();
    } else if (!_isInitialized || _controller == null) {
      content = widget.placeholder ?? const ColoredBox(color: SilkColors.dark);
    } else {
      content = ColoredBox(
        color: SilkColors.dark,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _CameraViewfinderWithBlur(
              controller: _controller!,
              fit: widget.fit,
              isBlurred: _isSwitchingCameras,
            ),
            if (widget.showControls)
              RepaintBoundary(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _flashEnabled,
                  builder: (_, flashEnabled, _) => SilkCameraControl(
                    flashEnabled: flashEnabled,
                    isSwitching: _isSwitchingCameras,
                    onFlashToggle: _toggleFlash,
                    onCapture: _capture,
                    onSwitchCamera: _switchCamera,
                    onGallery: widget.onGallery,
                    onClose: widget.onClose,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    content = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: content,
    );

    return hasSize
        ? SizedBox(width: widget.width, height: widget.height, child: content)
        : SizedBox.expand(child: content);
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
            size: _CameraGap.fallbackIconSize,
          ),
        ),
      ),
    );
  }
}

class _CameraViewfinderWithBlur extends StatelessWidget {
  final CameraController controller;
  final CameraPreviewFit fit;
  final bool isBlurred;

  const _CameraViewfinderWithBlur({
    required this.controller,
    required this.fit,
    required this.isBlurred,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SilkCameraViewfinder(controller: controller, fit: fit),
        if (isBlurred)
          AnimatedOpacity(
            duration: SilkAnimation.duration,
            opacity: 1.0,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.transparent),
            ),
          ),
      ],
    );
  }
}

enum SensorPosition { back, front }

enum CameraPreviewFit { cover, contain, fill, fitWidth, fitHeight }
