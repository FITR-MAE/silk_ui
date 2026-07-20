# silk_ui

Minimal, image-first Flutter UI components for FITR-MAE products. The package
provides the shared visual system used by the lume app, with warm neutral
surfaces, restrained indigo accents, flat defaults, and Material 3 semantics.

## Components

| Area | Public components |
| --- | --- |
| Actions | `SilkButton`, `SilkIconButton` |
| Content | `SilkAvatar`, `SilkBadge`, `SilkCard`, `SilkDivider`, `SilkIcon`, `SilkImage` |
| Inputs | `SilkInput`, `SilkFilterChip`, `SilkHashtag`, `SilkToggleChip` |
| Layout | `SilkGrid`, `SilkStack`, `SilkTabs`, `SilkPage` |
| Navigation | `SilkDrawer`, `SilkTabNavigation`, `SilkPillTabBar` |
| Feedback | `SilkLoadingDots`, `SilkSkeleton` |
| Motion | `SilkFadeIn`, `SilkSlideIn`, `SilkStaggeredList` |
| Media | `SilkCamera` |
| Typography | `SilkText`, `SilkTitle`, `SilkSpan` |

## Theme

```dart
import 'package:silk_ui/silk_ui.dart';

MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
);
```

Components resolve theme-aware tokens through `SilkColorScheme.of(context)`.
Spacing follows a 4-point grid, and shadows are opt-in.
`SilkPillTabBar` uses the compact image-overlay geometry: 3px shell padding,
10×2px item padding, and 11px labels.

## Development

```bash
flutter pub get
dart format lib test
flutter analyze
flutter test
```

See `.workspace/REVIEW_PLAN.md` for the current audit and
`.workspace/documentation/` for exact design tokens.
