# Scale

## Overview

Scale enums are component-owned and live next to the component that uses them.

Current exported scale enums:

- `ButtonScale` in `lib/src/components/button/button.dart`
- `CardScale` in `lib/src/components/card/card.dart`
- `TextScale` in `lib/src/components/text/text.dart`
- `TitleScale` in `lib/src/components/text/title.dart`

Current exported layout value enums:

- `GridValue` in `lib/src/components/layout/grid.dart`
- `StackValue` in `lib/src/components/layout/stack.dart`
- `StackOrientation` in `lib/src/components/layout/stack.dart`

## ButtonScale

`ButtonScale` values:

- `xs`
- `sm`
- `md`
- `lg`

`ButtonScale` controls:

- button vertical padding
- button horizontal padding
- button font size
- icon button icon size
- icon button square side length

### Button Font Size By Scale

- `xs = 11.0`
- `sm = 12.0`
- `md = 14.0`
- `lg = 16.0`

## CardScale

`CardScale` values:

- `xs`
- `sm`
- `md`
- `lg`

`CardScale` currently controls card padding.

Card elevation is not scale-driven. Shadow is controlled separately through `SilkShadow`.

## TextScale

`TextScale` values:

- `xs`
- `sm`
- `md`
- `lg`

### Text Font Size By Scale

- `xs = 10.0`
- `sm = 12.0`
- `md = 16.0`
- `lg = 20.0`

`SilkText` uses the `scale` property, not `size`.

## TitleScale

`TitleScale` values:

- `h1`
- `h2`
- `h3`

### Title Font Size By Scale

- `h1 = 32.0`
- `h2 = 24.0`
- `h3 = 20.0`

`SilkTitle` uses the `scale` property, not `level`.

## Related Non-Scale Enums

These enums are also component-owned but represent style choices rather than size scales:

- `ButtonVariant` with `primary`, `secondary`, `alt`
- `CardVariant` with `primary`, `secondary`
- `SilkShadow` with `none`, `xs`, `sm`, `md`, `lg`
