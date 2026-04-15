import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera.dart';

class SilkCameraViewfinder extends StatelessWidget {
  final CameraController controller;
  final CameraPreviewFit fit;

  const SilkCameraViewfinder({
    super.key,
    required this.controller,
    this.fit = CameraPreviewFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final previewSize = controller.value.previewSize;
    final preview = RepaintBoundary(child: CameraPreview(controller));

    if (fit == CameraPreviewFit.fill || previewSize == null) {
      return SizedBox.expand(child: preview);
    }

    return FittedBox(
      fit: _toBoxFit(fit),
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
}
