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
│       ├── theme/                 # Shared theme values only
│       │   ├── colors.dart        # SilkColors palette
│       │   ├── sizing.dart        # SilkShadow + ShadowConfig
│       │   ├── spacing.dart       # SilkSpacing shared border/timing values
│       │   └── index.dart         # Re-exports all theme values
│       └── util/                  # Future utilities
├── test/                          # Widget tests (38 passing)
└── pubspec.yaml                   # Dependencies (phosphor_flutter)
```

## Components

| Component | File | Props |
|-----------|------|-------|
| `SilkButton` | `components/button/button.dart` | `label`, `scale` (`ButtonScale.xs/sm/md/lg`), `variant` (primary/secondary/alt), `isLoading`, `isDisabled`, `onPressed`, `leading`, `trailing`, `backgroundColor`, `shadow`, `borderRadius` |
| `SilkIconButton` | `components/button/icon_button.dart` | `icon` (Phosphor), `iconColor`, `scale`, `variant`, `isLoading`, `isDisabled`, `onPressed` (inherits `SilkButton` and forces square shape) |
| `SilkCard` | `components/card/card.dart` | `child`, `scale` (`CardScale.xs/sm/md/lg`), `elevation`, `borderRadius`, `padding`, `backgroundColor`, `align` (Alignment.centerLeft default), `shadow`, `variant` |
| `SilkImage` | `components/img/img.dart` | `src` (asset/network), `fit`, `borderRadius`, `width`, `height`, `shadow` (SilkShadow.none default) |
| `SilkIcon` | `components/icon/icon.dart` | `icon` (PhosphorIconData), `size`, `color` |
| `SilkText` | `components/text/text.dart` | `text`, `scale` (`TextScale.xs/sm/md/lg`), `color`, `maxLines`, `textAlign` (TextAlign.start default) |
| `SilkTitle` | `components/text/title.dart` | `text`, `scale` (`TitleScale.h1/h2/h3`), `color`, `textAlign` (TextAlign.start default) |
| `SilkSpan` | `components/text/span.dart` | `text`, `fontStyle`, `fontWeight`, `textDecoration`, `color`, `maxLines` |

## Theme

### Colors (`theme/colors.dart`)
Based on `.workspace/notes/colours.md` and `tmp/colours.md`:
```dart
// Primary/Secondary (text colors):
SilkColors.primary       // dark (#141414)
SilkColors.secondary     // light (#f5f5f5)

// Surface (backgrounds):
SilkColors.surface       // cornsilk (#FEFAE0) - light mode
SilkColors.surfaceDark   // grey (#595959) - dark mode

// Theme colours:
SilkColors.outline       // black-forest (#283618)
SilkColors.disabled
SilkColors.onPrimary     // light (#f5f5f5)
SilkColors.onSecondary   // dark (#141414)
SilkColors.dark          // #141414
SilkColors.light         // #f5f5f5
SilkColors.grey          // #595959
SilkColors.oliveLeaf     // #606C38
SilkColors.blackForest   // #283618
SilkColors.cornsilk      // #FEFAE0
SilkColors.sunlitClay    // #DDA15E
SilkColors.copperwood    // #BC6C25
```

### Shared Theme Values
```dart
// theme/shadow.dart
SilkShadow { none, xs, sm, md, lg }

// theme/spacing.dart
SilkBorder.radius = 8.0
SilkSpacing.xs = 8.0
SilkSpacing.sm = 12.0
SilkSpacing.md = 16.0
SilkSpacing.lg = 24.0

// theme/border.dart
SilkBorder.width = 0.8
SilkBorder.style = BorderStyle.solid
SilkBorder.radius = 8.0

// theme/animation.dart
SilkAnimation.duration = 200ms

// Shared shadow config used by button, card, image
ShadowConfig.none  // no shadow (default)
ShadowConfig.xs    // elevation 1, color #14000000
ShadowConfig.sm    // elevation 2, color #1A000000
ShadowConfig.md    // elevation 4, color #29000000
ShadowConfig.lg    // elevation 8, color #3D000000
```

### Component-Owned Definitions
- `components/button/button.dart`: `ButtonVariant`, `ButtonScale`, `ButtonGap`
- `components/button/icon_button.dart`: `IconButtonGap`
- `components/card/card.dart`: `CardVariant`, `CardScale`, `CardGap`
- `components/text/text.dart`: `TextScale`, `TextGap`
- `components/text/title.dart`: `TitleScale`, `TitleGap`

## Usage

```dart
import 'package:silk_ui/silk_ui.dart';

// Button
SilkButton(
  label: 'Scan Outfit',
  scale: ButtonScale.lg,
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
  scale: ButtonScale.md,
  variant: ButtonVariant.primary,
  onPressed: () {},
)

// Card
SilkCard(
  scale: CardScale.md,
  variant: CardVariant.primary,
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
  scale: TextScale.md,
)

// Title
SilkTitle(
  text: 'Welcome',
  scale: TitleScale.h1,
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
2. Keep component-specific enums/gaps in the component file
3. Import shared theme values from `theme/` only when needed
4. Export from `src/components/<category>/<component>.dart`
5. Add export to `lib/silk_ui.dart`
6. Write widget tests in `test/`

## Architecture Notes

### Theme-Aware Components
Components check `Theme.of(context).brightness` to determine foreground text color:
- **Light mode**: uses `SilkColors.dark`
- **Dark mode**: uses `SilkColors.light`
- `SilkText` and `SilkTitle` use theme-aware defaults unless `color` is passed

`silk_ui/theme/colors.dart` provides SilkColors palette aligned with colours.md.

### SilkButton Inheritance
- `SilkButton` is the base button component with `leading`/`trailing` slots for icons
- `SilkIconButton` extends `SilkButton`, sets `leading` to a `SilkIcon`, forces `borderRadius: 0`, and uses a fixed square side per scale
- Both share `scale`, `variant`, `isLoading`, `isDisabled`, `onPressed` via inheritance

### Variant Behavior
| Variant | Light Background | Dark Background | Text Color |
|---------|-----------------|------------------|------------|
| primary | oliveLeaf | oliveLeaf | theme-aware dark/light |
| secondary | transparent | transparent | theme-aware dark/light |
| alt | transparent | transparent | oliveLeaf |

### Card Behavior
| Variant | Border | Background | Text |
|---------|--------|------------|------|
| primary | oliveLeaf | transparent | theme-aware dark/light |
| secondary | oliveLeaf | oliveLeaf | theme-aware dark/light |

(End of file - total 213 lines)
