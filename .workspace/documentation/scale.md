# Component Scales

## Size Enums

- `ButtonScale`: xs, sm, md, lg
- `CardScale`: xs, sm, md, lg
- `TextScale`: xs, sm, md, lg
- `TitleScale`: h1, h2, h3
- `BadgeScale`: xs, sm, md, lg
- `GridValue`: xs, sm, md, lg
- `StackGap`: xs, sm, md, lg

## Variants

- `ButtonVariant`: primary, secondary, outline, ghost, accent, alt
- `CardVariant`: primary, secondary, elevated, ghost
- `BadgeVariant`: primary, secondary, destructive, success, outline
- `SilkTabStyle`: pill, button, outline
- `SilkTabsVariant`: list, overlay
- `SilkDrawerPlacement`: bottom, left, right

`SilkTabs` owns a `TabController`, reports each settled index once, and safely
recreates its controller when item count changes. `SilkTabNavigation` may use a
caller-owned controller.
