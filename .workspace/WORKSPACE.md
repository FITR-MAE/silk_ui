# silk_ui Workspace

## Overview

- Type: reusable Flutter package
- Consumer: `../lume/packages/app/`
- Public API: `lib/silk_ui.dart`
- Design direction: image-first, warm neutral, flat, modern, and minimalist

## Architecture

- `lib/src/theme/` owns all shared color, spacing, border, shadow, motion, and
  typography tokens.
- `SilkColorScheme` is the canonical theme-aware color source.
- `AppTheme.light` and `AppTheme.dark` are the supported Material 3 themes.
- Components own scale enums and co-located sizing helpers where needed.
- Shadows default to `SilkShadow.none` and are explicitly enabled by callers.
- Internal camera controls and viewfinder widgets are not barrel-exported.

## Public Areas

- Actions: buttons and icon buttons
- Content: avatar, badge, card, divider, icon, and image
- Inputs: text input and chip variants
- Layout: grid, stack, tabs, page, and pill tab bar
- Navigation: drawer and controller-aware tab navigation
- Feedback and motion: loading, skeleton, fade, slide, and staggered list
- Media: lifecycle-aware camera capture
- Typography: text, title, and span

## Camera

`SilkCamera` serializes debounced open/close transitions and invalidates stale
requests across lifecycle and `isActive` changes. Tests must inject
`availableCamerasLoader`; never access real camera hardware in a widget test.
Successful captures are delivered before optional camera-roll persistence.

## Navigation

`SilkTabNavigation` can own its controller or accept a caller-owned
`TabController`. Controller length must match the item count. Pages are not kept
mounted unless `keepPagesMounted` is true. `hideBottomBar` removes both the bar
and its content inset.

## Verification

```bash
flutter pub get
dart format lib test
flutter analyze
flutter test
```

The lume app must also pass `flutter analyze` after public API changes.
