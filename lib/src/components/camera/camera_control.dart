import 'package:flutter/material.dart';

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
  final VoidCallback? onClose;

  const SilkCameraControl({
    super.key,
    this.flashEnabled = false,
    this.isSwitching = false,
    this.onFlashToggle,
    this.onCapture,
    this.onSwitchCamera,
    this.onGallery,
    this.onClose,
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
            left: SilkSpacing.s4,
            right: SilkSpacing.s4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (onClose != null)
                _CircleButton(
                  label: 'Close camera',
                  icon: Icons.close_rounded,
                  onPressed: onClose,
                )
              else
                const SizedBox(width: 44),
              _CircleButton(
                label: flashEnabled ? 'Turn flash off' : 'Turn flash on',
                icon: flashEnabled
                    ? Icons.flash_on_rounded
                    : Icons.flash_off_rounded,
                onPressed: onFlashToggle,
                active: flashEnabled,
              ),
            ],
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
              if (onGallery != null)
                _GalleryButton(onTap: onGallery)
              else
                const SizedBox(width: 48, height: 48),
              _CaptureButton(onTap: onCapture, isSwitching: isSwitching),
              _CircleButton(
                label: 'Switch camera',
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
  final String label;
  final VoidCallback? onPressed;
  final bool active;

  const _CircleButton({
    required this.icon,
    required this.label,
    this.onPressed,
    this.active = false,
  });

  @override
  State<_CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<_CircleButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final pressDuration = disableAnimations
        ? Duration.zero
        : SilkAnimation.fast;
    final containerDuration = disableAnimations
        ? Duration.zero
        : SilkAnimation.duration;
    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      child: GestureDetector(
        onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
        onTapUp: (_) {
          setState(() => _pressed = false);
          if (enabled) widget.onPressed!();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: _pressed ? 0.88 : 1,
          duration: pressDuration,
          curve: SilkAnimation.spring,
          child: AnimatedContainer(
            duration: containerDuration,
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

class _CaptureButtonState extends State<_CaptureButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null && !widget.isSwitching;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final pressDuration = disableAnimations
        ? Duration.zero
        : SilkAnimation.fast;
    final switchDuration = disableAnimations
        ? Duration.zero
        : SilkAnimation.duration;
    return Semantics(
      button: true,
      enabled: enabled,
      label: 'Take photo',
      child: GestureDetector(
        onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
        onTapUp: enabled
            ? (_) {
                setState(() => _pressed = false);
                widget.onTap!();
              }
            : null,
        onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
        child: AnimatedContainer(
          duration: pressDuration,
          curve: SilkAnimation.spring,
          width: 72,
          height: 72,
          transform: Matrix4.diagonal3Values(
            _pressed ? 0.88 : 1,
            _pressed ? 0.88 : 1,
            1,
          ),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: AnimatedSwitcher(
            duration: switchDuration,
            child: widget.isSwitching
                ? Padding(
                    padding: const EdgeInsets.all(14),
                    child: CircularProgressIndicator(
                      value: disableAnimations ? 0.75 : null,
                      strokeWidth: 2,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
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

class _GalleryButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _GalleryButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: onTap != null,
      label: 'Open gallery',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SilkBorder.radiusMd),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.5,
            ),
            color: Colors.black.withValues(alpha: 0.3),
          ),
          child: const Icon(
            Icons.photo_library_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
