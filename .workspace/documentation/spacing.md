# Spacing

## Shared Tokens

### `SilkSpacing`

Used for padding and margin-style spacing.

- `SilkSpacing.defaultValue = 4.0`
- `SilkSpacing.xs = 1.0`
- `SilkSpacing.sm = 2.0`
- `SilkSpacing.md = 4.0`
- `SilkSpacing.lg = 8.0`
- Icon button icon sizes: `iconButtonIconXs=16`, `iconButtonIconSm=20`, `iconButtonIconMd=24`, `iconButtonIconLg=28`
- Icon button side lengths: `iconButtonSideXs=28`, `iconButtonSideSm=36`, `iconButtonSideMd=48`, `iconButtonSideLg=56`

### `SilkGap`

Used for inter-component gaps.

- `SilkGap.defaultValue = 8.0`
- `SilkGap.sm = 4.0`
- `SilkGap.md = 8.0`
- `SilkGap.lg = 16.0`

### `SilkBorder`

- `SilkBorder.width = 0.4`
- `SilkBorder.radiusDefault = 4.0`
- `SilkBorder.radiusSm = 2.0`
- `SilkBorder.radiusMd = 4.0`
- `SilkBorder.radiusLg = 8.0`
- `SilkBorder.radiusRound = 999.0`

## Button Spacing

`lib/src/components/button/gap.dart`

- `ButtonGap.content = SilkGap.sm`
- vertical padding: `xs/sm -> SilkSpacing.sm`, `md -> SilkSpacing.md`, `lg -> SilkSpacing.lg`
- horizontal padding: `xs/sm -> SilkSpacing.md`, `md/lg -> SilkSpacing.lg`

### Icon Button Sizing

- icon size: `xs 16`, `sm 20`, `md 24`, `lg 28`
- square side: `xs 28`, `sm 36`, `md 48`, `lg 56`

## Card Spacing

`lib/src/components/card/gap.dart`

- padding: `xs/sm -> SilkSpacing.sm`, `md -> SilkSpacing.md`, `lg -> SilkSpacing.lg`

## Text and Title Sizing

`lib/src/components/text/gap.dart`

- `TextScale.xs/sm -> SilkTypography.sm`
- `TextScale.md -> SilkTypography.md`
- `TextScale.lg -> SilkTypography.lg`
- `TitleScale.h1 -> SilkTypography.md * 2`
- `TitleScale.h2 -> SilkTypography.sm * 2`
- `TitleScale.h3 -> SilkTypography.lg`

## Layout Spacing

### `SilkGrid`

- `GridValue.sm -> SilkGap.sm`
- `GridValue.md -> SilkGap.md`
- `GridValue.lg -> SilkGap.lg`
- default outer padding: `EdgeInsets.all(SilkSpacing.md)`

### `SilkStack`

- `StackValue.sm -> SilkGap.sm`
- `StackValue.md -> SilkGap.md`
- `StackValue.lg -> SilkGap.lg`

### `SilkTabs`

- tab list padding: `SilkSpacing.sm`
- item padding: horizontal `SilkSpacing.md`, vertical `SilkSpacing.sm`
- item gap: `SilkGap.sm`
- radius: `SilkBorder.radiusLg`

## Navigation Spacing

`lib/src/components/navigation/gap.dart`

- container padding: `SilkSpacing.sm`
- item padding: horizontal `SilkSpacing.md`, vertical `SilkSpacing.sm`
- item gap: `SilkGap.sm`
- tab height: `IconButtonGap.side(ButtonScale.sm)`
- drawer padding: `EdgeInsets.all(SilkGap.lg)`
- drawer handle width: `SilkGap.lg * 6`
- drawer handle height: `SilkSpacing.md * 2`

## Badge Spacing

`lib/src/components/badge/gap.dart`

- gap between leading and text: `SilkGap.sm`
- icon size: `SilkTypography.md`
- pill radius: `SilkBorder.radiusRound`
- non-pill radius: `SilkBorder.radiusMd`
