# silk_ui Workspace

## Overview

- Path: `../` (workspace-relative — lives at `/home/elias/Desktop/bramble-labs/silk_ui/`)
- Type: Flutter UI component library
- Purpose: reusable UI components for current and future apps

## Public API

`lib/silk_ui.dart` exports the full public surface.

### Components

- `SilkButton` and `SilkIconButton`
- `SilkBadge`
- `SilkCard`
- `SilkCamera`
- `SilkIcon`
- `SilkImage`
- `SilkGrid`, `SilkStack`, `SilkTabs`
- `SilkTabNavigation`
- `SilkDrawer`
- `SilkText`, `SilkTitle`, `SilkSpan`

### Theme

- `AppTheme.light`, `AppTheme.dark`
- `SilkAnimation`
- `SilkBorder`
- `SilkColors`
- `SilkGap`
- `SilkShadow`, `ShadowConfig`
- `SilkSpacing`
- `SilkTypography`

## Structure

```text
silk_ui/
├── lib/
│   ├── silk_ui.dart
│   └── src/
│       ├── components/
│       │   ├── badge/
│       │   ├── button/
│       │   ├── camera/
│       │   ├── card/
│       │   ├── icon/
│       │   ├── img/
│       │   ├── layout/
│       │   ├── navigation/
│       │   └── text/
│       └── theme/
│           ├── animation.dart
│           ├── app_theme.dart
│           ├── border.dart
│           ├── colors.dart
│           ├── gap.dart
│           ├── index.dart
│           ├── shadow.dart
│           ├── spacing.dart
│           └── typography.dart
├── test/
└── pubspec.yaml
```

## Shared Tokens

### Colors

- `SilkColors.dark = #141414`
- `SilkColors.light = #F5F5F5`
- `SilkColors.grey = #595959`
- `SilkColors.destructive = #DC2626`
- `SilkColors.powderPetal = #FFE5D9`
- `SilkColors.cherryBlossom = #F4ACB7`
- `SilkColors.alabasterGrey = #D8E2DC`
- `SilkColors.pastelPink = #FFCAD4`
- `SilkColors.dustyMauve = #9D8189`

### Spacing

- `SilkSpacing.defaultValue = 4.0`
- `SilkSpacing.xs = 1.0`
- `SilkSpacing.sm = 2.0`
- `SilkSpacing.md = 4.0`
- `SilkSpacing.lg = 8.0`

### Gap

- `SilkGap.defaultValue = 8.0`
- `SilkGap.sm = 4.0`
- `SilkGap.md = 8.0`
- `SilkGap.lg = 16.0`

### Border

- `SilkBorder.width = 0.4`
- `SilkBorder.radiusDefault = 4.0`
- `SilkBorder.radiusSm = 2.0`
- `SilkBorder.radiusMd = 4.0`
- `SilkBorder.radiusLg = 8.0`
- `SilkBorder.radiusRound = 999.0`

### Typography

- `SilkTypography.sm = 12.0`
- `SilkTypography.md = 16.0`
- `SilkTypography.lg = 24.0`

### Shadow

- `SilkShadow.none`, `xs`, `sm`, `md`, `lg`
- `ShadowConfig.none = elevation 0`
- `ShadowConfig.xs = elevation 1`
- `ShadowConfig.sm = elevation 2`
- `ShadowConfig.md = elevation 4`
- `ShadowConfig.lg = elevation 8`

## Component Notes

### Buttons

- `ButtonVariant.primary`: dark fill, light text, dark border
- `ButtonVariant.secondary`: transparent in light theme, grey fill in dark theme
- `ButtonVariant.alt`: transparent with theme-aware text and no border
- `SilkIconButton` is always square and forces `borderRadius: 0`

### Cards

- `CardVariant.primary`: transparent background with theme-aware border
- `CardVariant.secondary`: transparent in light theme, grey in dark theme

### Layout

- `SilkGrid` uses `GridValue.sm/md/lg` via `.gap` to derive item spacing from `SilkGap`
- `SilkStack` uses `StackValue.sm/md/lg` via `.gap` and supports `vertical` or `horizontal`
- `SilkTabs` is stateful, owns its active tab, supports swipe switching, and supports `pill`, `button`, and `outline` styles

### Navigation

- `SilkTabNavigation` is for app-level tab navigation across screens and reports selection via `onChanged`
- `SilkDrawer.show(...)` supports `bottom`, `left`, and `right` placements
- Bottom drawer behavior is built with `showModalBottomSheet`

### Camera

- `SilkCamera` manages its own camera setup by default
- `SilkCamera` also accepts an external `CameraController`
- `camera: ^0.11.0` is required in `pubspec.yaml`

### Badge

- `BadgeVariant.primary`, `secondary`, `destructive`, `outline`
- `BadgeScale.sm`, `md`, `lg`
- `isPill: true` uses `SilkBorder.radiusRound`

## Commands

```bash
flutter pub get
dart format lib test
flutter test
flutter analyze
```
