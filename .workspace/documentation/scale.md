# Scale

## Component-Owned Enums

### Size Scales

- `ButtonScale` in `lib/src/components/button/button.dart`
- `CardScale` in `lib/src/components/card/card.dart`
- `TextScale` in `lib/src/components/text/text.dart`
- `TitleScale` in `lib/src/components/text/title.dart`
- `BadgeScale` in `lib/src/components/badge/badge.dart`

### Layout and Navigation Values

- `GridValue` in `lib/src/components/layout/grid.dart`
- `StackValue` and `StackOrientation` in `lib/src/components/layout/stack.dart`
- `SilkTabStyle` in `lib/src/components/layout/tabs.dart`
- `SilkDrawerPlacement` in `lib/src/components/navigation/drawer.dart`

## ButtonScale

- `xs`, `sm`, `md`, `lg`
- controls button padding, button font size, icon size, and icon-button square side

## CardScale

- `xs`, `sm`, `md`, `lg`
- controls card padding

## TextScale

- `xs`, `sm`, `md`, `lg`
- maps to `SilkTypography.sm`, `sm`, `md`, `lg`

## TitleScale

- `h1`, `h2`, `h3`
- `h1 = SilkTypography.md * 2`
- `h2 = SilkTypography.sm * 2`
- `h3 = SilkTypography.lg`

## BadgeScale

- `xs`, `sm`, `md`, `lg`
- controls badge padding and font size

## Related Variant Enums

- `ButtonVariant`: `primary`, `secondary`, `alt`
- `CardVariant`: `primary`, `secondary`
- `BadgeVariant`: `primary`, `secondary`, `destructive`, `outline`
- `SilkShadow`: `none`, `xs`, `sm`, `md`, `lg`

## Tabs

`SilkTabs` owns its selected tab state.

- supports `pill`, `button`, and `outline` styles
- supports tap switching and horizontal swipe switching
- each tab is defined by `SilkTabItem(label, child, icon?)`

## Tab Navigation

`SilkTabNavigation` is controlled from the parent.

- parent owns `currentIndex`
- selection is reported through `onChanged`
- each item is defined by `SilkTabNavigationItem(label, icon?)`
