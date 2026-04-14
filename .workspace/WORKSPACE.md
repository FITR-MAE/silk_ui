# silk_ui Workspace

## Overview
**Path:** `/home/elias/silk_ui`  
**Type:** Flutter UI component library  
**Purpose:** Reusable UI components for lume and future projects

## Project Structure

```
silk_ui/
├── lib/
│   ├── silk_ui.dart               # Main export (re-exports all public APIs)
│   └── src/
│       ├── components/            # UI widgets
│       │   ├── button/
│       │   │   ├── button.dart  # SilkButton
│       │   │   └── icon_button.dart # SilkIconButton
│       │   ├── card/
│       │   │   └── card.dart    # SilkCard
│       │   ├── img/
│       │   │   └── img.dart     # SilkImage
│       │   └── text/
│       │       ├── text.dart    # SilkText
│       │       ├── title.dart   # SilkTitle
│       │       └── span.dart    # SilkSpan
│       ├── theme/                # Shared theme values
│       │   ├── colors.dart      # SilkColors palette
│       │   ├── spacing.dart    # Enums & spacing constants
│       │   └── index.dart      # Re-exports all theme values
│       └── util/                # Future utilities
├── test/                        # Widget tests (37 passing)
└── pubspec.yaml                # Dependencies (phosphor_flutter)
```

## Components

| Component | File | Props |
|-----------|------|-------|
| `SilkButton` | `components/button/button.dart` | `label`, `size` (sm/md/lg), `variant` (primary/secondary/outline), `isLoading`, `isDisabled`, `onPressed` |
| `SilkIconButton` | `components/button/icon_button.dart` | `icon` (Phosphor), `size`, `isLoading`, `isDisabled`, `onPressed`, `backgroundColor`, `iconColor` |
| `SilkCard` | `components/card/card.dart` | `child`, `elevation`, `borderRadius`, `padding`, `backgroundColor` |
| `SilkImage` | `components/img/img.dart` | `src` (asset/network), `fit`, `borderRadius`, `width`, `height` |
| `SilkText` | `components/text/text.dart` | `text`, `size` (sm/md/lg), `color`, `maxLines` |
| `SilkTitle` | `components/text/title.dart` | `text`, `level` (h1/h2/h3), `color` |
| `SilkSpan` | `components/text/span.dart` | `text`, `fontStyle`, `fontWeight`, `textDecoration`, `color`, `maxLines` |

## Theme

### Colors (`theme/colors.dart`)
```dart
SilkColors.primary       // olive-leaf (#606C38)
SilkColors.secondary     // copperwood (#BC6C25)
SilkColors.outline       // black-forest (#283618)
SilkColors.surface       // cornsilk (#FEFAE0)
SilkColors.disabled
SilkColors.onPrimary     // cornsilk (#FEFAE0)
SilkColors.onSecondary    // cornsilk (#FEFAE0)
SilkColors.dark
SilkColors.light
SilkColors.oliveLeaf     // #606C38
SilkColors.blackForest   // #283618
SilkColors.cornsilk      // #FEFAE0
SilkColors.sunlitClay    // #DDA15E
SilkColors.copperwood    // #BC6C25
```

### Spacing & Enums (`theme/spacing.dart`)
```dart
// Enums
ButtonSize { sm, md, lg }
ButtonVariant { primary, secondary, outline }
SilkTextSize { sm, md, lg }
SilkTitleLevel { h1, h2, h3 }

// Button Spacing
ButtonSpacing.borderRadius = 12.0
ButtonSpacing.borderWidth = 2.0
ButtonSpacing.animationDuration = 150ms
ButtonSpacing.paddingVerticalSm/Md/Lg
ButtonSpacing.paddingHorizontalSm/Md/Lg
ButtonSpacing.fontSizeSm/Md/Lg
ButtonSpacing.iconSizeSm/Md/Lg
ButtonSpacing.containerSizeSm/Md/Lg

// Typography Spacing
TypographySpacing.titleH1/H2/H3
TypographySpacing.textSm/Md/Lg
TypographySpacing.textColorSm/Md/Lg

// Card Spacing
CardSpacing.defaultElevation = 2.0
CardSpacing.defaultBorderRadius = 12.0
CardSpacing.defaultPadding = 16.0
```

## Usage

```dart
import 'package:silk_ui/silk_ui.dart';

// Button
SilkButton(
  label: 'Scan Outfit',
  size: ButtonSize.lg,
  variant: ButtonVariant.primary,
  onPressed: () {},
)

// Icon Button
SilkIconButton(
  icon: PhosphorIcons.camera(),
  size: ButtonSize.md,
  onPressed: () {},
)

// Card
SilkCard(
  elevation: 4,
  borderRadius: 16,
  child: Text('Content'),
)

// Image
SilkImage(
  src: 'https://example.com/image.png',
  borderRadius: 8,
  fit: BoxFit.cover,
)

// Text
SilkText(
  text: 'Description',
  size: SilkTextSize.md,
)

// Title
SilkTitle(
  text: 'Welcome',
  level: SilkTitleLevel.h1,
)

// Span
SilkSpan(
  text: 'italic text',
  fontStyle: FontStyle.italic,
)
```

## Commands

```bash
# Run tests
cd /home/elias/silk_ui && flutter test

# Run tests with coverage
cd /home/elias/silk_ui && flutter test --coverage

# Update dependencies
cd /home/elias/silk_ui && flutter pub get

# Analyze
cd /home/elias/silk_ui && flutter analyze
```

## Adding New Components

1. Create component file in `src/components/<category>/`
2. Define component class using theme constants
3. Import theme from `'../../theme/spacing.dart'` and `'../../theme/colors.dart'`
4. Export from `src/components/<category>/<component>.dart`
5. Add export to `lib/silk_ui.dart`
6. Write widget tests in `test/`
