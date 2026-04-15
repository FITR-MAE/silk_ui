# Typography

## Shared Typography Tokens

Defined in `lib/src/theme/typography.dart`.

- `SilkTypography.sm = 12.0`
- `SilkTypography.md = 16.0`
- `SilkTypography.lg = 24.0`

## Text Components

### `SilkText`

- `TextScale.xs -> SilkTypography.sm`
- `TextScale.sm -> SilkTypography.sm`
- `TextScale.md -> SilkTypography.md`
- `TextScale.lg -> SilkTypography.lg`

### `SilkTitle`

- `TitleScale.h1 -> SilkTypography.md * 2`
- `TitleScale.h2 -> SilkTypography.sm * 2`
- `TitleScale.h3 -> SilkTypography.lg`
- all title scales use `FontWeight.bold`

### `SilkBadge`

- `BadgeScale.sm -> SilkTypography.sm`
- `BadgeScale.md -> SilkTypography.md`
- `BadgeScale.lg -> SilkTypography.md`

### Tabs and Navigation

- `SilkTabs` trigger labels use `SilkTypography.sm`
- `SilkTabNavigation` labels use `SilkTypography.sm`
- tab and navigation icons use `SilkTypography.md`
