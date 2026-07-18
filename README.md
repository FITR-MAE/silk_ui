# silk_ui

Reusable Flutter UI component library for bramble-labs applications. Provides
`Silk*` widgets and a Material 3 `AppTheme` used by the lume app.

## Components

| Component | Description |
|---|---|
| `SilkButton` | Primary/secondary/destructive/outline buttons with multiple scales |
| `SilkIconButton` | Icon-only button with variant support |
| `SilkBadge` | Small label (primary/secondary/destructive/outline, sm/md/lg) |
| `SilkCard` | Elevated card container (primary/secondary variants) |
| `SilkCamera` | Full camera capture widget with async state management |
| `SilkIcon` | Simple icon wrapper |
| `SilkImage` | Image display widget |
| `SilkGrid` / `SilkStack` | Layout helpers |
| `SilkTabs` | Tab bar (pill/button/outline styles) |
| `SilkTabNavigation` | App-level tab navigation shell |
| `SilkDrawer` | Slide-out drawer (bottom/left/right) |
| `SilkText` / `SilkTitle` / `SilkSpan` | Typography components |

## Theme

```dart
import 'package:silk_ui/silk_ui.dart';

MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  // ...
);
```

All design tokens (colours, spacing, typography, shadows) live in
`lib/src/theme/`. Components resolve theme-aware values at runtime via
`Theme.of(context).brightness`.

## Getting started

```yaml
# pubspec.yaml
dependencies:
  silk_ui:
    path: ../silk_ui   # assumes sibling directory
```

```bash
flutter pub get
```

## Development

```bash
dart format lib test   # format
flutter analyze        # lint
flutter test           # run tests
```

See `AGENTS.md` for detailed conventions, component internals, and design
token documentation.

## Design tokens

Token reference docs: `.workspace/documentation/` (`colour.md`, `spacing.md`,
`typography.md`, `shadow.md`, `scale.md`).
