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
│       │   │   ├── button.dart   # SilkButton
│       │   │   └── icon_button.dart # SilkIconButton (extends SilkButton)
│       │   ├── card/
│       │   │   └── card.dart      # SilkCard
│       │   ├── icon/
│       │   │   └── icon.dart      # SilkIcon
│       │   ├── img/
│       │   │   └── img.dart       # SilkImage
│       │   └── text/
│       │       ├── text.dart      # SilkText
│       │       ├── title.dart     # SilkTitle
│       │       └── span.dart      # SilkSpan
│       ├── theme/                 # Shared theme values
│       │   ├── colors.dart        # SilkColors palette
│       │   ├── spacing.dart        # Enums & spacing constants
│       │   └── index.dart          # Re-exports all theme values
│       └── util/                  # Future utilities
├── test/                          # Widget tests (38 passing)
└── pubspec.yaml                   # Dependencies (phosphor_flutter)
```

## Components

| Component | File | Props |
|-----------|------|-------|
| `SilkButton` | `components/button/button.dart` | `label`, `size` (sm/md/lg), `variant` (primary/secondary/alt), `isLoading`, `isDisabled`, `onPressed`, `leading`, `trailing`, `backgroundColor` |
| `SilkIconButton` | `components/button/icon_button.dart` | `icon` (Phosphor), `iconColor`, `size`, `variant`, `isLoading`, `isDisabled`, `onPressed` (inherited from SilkButton) |
| `SilkCard` | `components/card/card.dart` | `child`, `elevation`, `borderRadius`, `padding`, `backgroundColor`, `align` (Alignment.centerLeft default) |
| `SilkImage` | `components/img/img.dart` | `src` (asset/network), `fit`, `borderRadius`, `width`, `height` |
| `SilkIcon` | `components/icon/icon.dart` | `icon` (PhosphorIconData), `size`, `color` |
| `SilkText` | `components/text/text.dart` | `text`, `size` (sm/md/lg), `color`, `maxLines`, `textAlign` (TextAlign.start default) |
| `SilkTitle` | `components/text/title.dart` | `text`, `level` (h1/h2/h3), `color`, `textAlign` (TextAlign.start default) |
| `SilkSpan` | `components/text/span.dart` | `text`, `fontStyle`, `fontWeight`, `textDecoration`, `color`, `maxLines` |

## Theme

### Colors (`theme/colors.dart`)
Based on `tmp/colours.md`:
```dart
// From colours.md:
// --dark: #141414;        /* dark & primary colour */
// --light: #f5f5f5;       /* light & secondary colour */

SilkColors.primary       // = dark (#141414)
SilkColors.secondary     // = light (#f5f5f5)
SilkColors.outline       // black-forest (#283618)
SilkColors.surface       // cornsilk (#FEFAE0)
SilkColors.disabled
SilkColors.onPrimary     // light (#f5f5f5)
SilkColors.onSecondary   // dark (#141414)
SilkColors.dark          // #141414
SilkColors.light         // #f5f5f5
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
ButtonVariant { primary, secondary, alt }
SilkTextSize { sm, md, lg }
SilkTitleLevel { h1, h2, h3 }

// Button Variants
// - primary:   filled with primary color
// - secondary:  filled with secondary color
// - alt:        no fill, thin border

// Button Spacing
ButtonSpacing.borderRadius = 12.0
ButtonSpacing.borderWidth = 2.0
ButtonSpacing.animationDuration = 150ms
ButtonSpacing.paddingVerticalSm/Md/Lg
ButtonSpacing.paddingHorizontalSm/Md/Lg
ButtonSpacing.fontSizeSm/Md/Lg
ButtonSpacing.iconSizeSm/Md/Lg
ButtonSpacing.containerSizeSm/Md/Lg
ButtonSpacing.iconButtonSizeSm/Md/Lg

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

// Button with leading icon
SilkButton(
  label: 'Scan Outfit',
  leading: SilkIcon(icon: PhosphorIcons.camera()),
  onPressed: () {},
)

// Icon Button (extends SilkButton)
SilkIconButton(
  icon: PhosphorIcons.camera(),
  size: ButtonSize.md,
  variant: ButtonVariant.primary,
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

// Icon
SilkIcon(
  icon: PhosphorIcons.star(),
  size: 24,
  color: SilkColors.primary,
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

## Architecture Notes

### Theme-Aware Components
Components check `Theme.of(context).brightness` to determine if a custom theme is set:
- **Light mode (default)**: Uses SilkColors from `tmp/colours.md` (primary=dark, secondary=light)
- **Dark mode**: Uses `Theme.of(context).colorScheme` values for theming
- **SilkCard**: Uses `colorScheme.surface` for both modes
- **SilkText**: Uses `textTheme.bodySmall/Medium/Large` for color fallback

`silk_ui/theme/colors.dart` provides SilkColors palette aligned with colours.md.

### SilkButton Inheritance
- `SilkButton` is the base button component with `leading`/`trailing` slots for icons
- `SilkIconButton` extends `SilkButton` and sets `leading` to a `SilkIcon`
- Both share `size`, `variant`, `isLoading`, `isDisabled`, `onPressed` via inheritance

### Variant Behavior
| Variant | Background | Border | Text Color |
|---------|------------|--------|------------|
| primary | SilkColors.primary (dark) | none | SilkColors.onPrimary (light) |
| secondary | SilkColors.secondary (light) | none | SilkColors.onSecondary (dark) |
| alt | transparent | SilkColors.outline | SilkColors.outline |

(End of file - total 213 lines)