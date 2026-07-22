# Component Scales

## Size Enums

- `ButtonScale`: xs, sm, md, lg; horizontal padding `12/16/20/24`, vertical
  padding `6/8/12/16`, text `14/14/16/18`
- `CardScale`: xs, sm, md, lg; padding `12/16/16/20`
- `TextScale`: xs, sm, md, lg; text `12/14/16/18`
- `TitleScale`: h1, h2, h3; text `30/24/20`
- `BadgeScale`: xs, sm, md, lg; text `10/12/14/16`
- `GridValue`: xs, sm, md, lg; gap `4/8/12/16`
- `StackGap`: xs, sm, md, lg; gap `4/8/12/16`

## Variants

- `ButtonVariant`: primary, secondary, outline, ghost, accent, alt
- `CardVariant`: primary, secondary, elevated, ghost
- `BadgeVariant`: primary, secondary, accent, outline, destructive, success
- `SilkTabStyle`: pill, button, outline
- `SilkTabsVariant`: list, overlay
- `PillTabStyle`: light, dark, outlined
- `SilkDrawerPlacement`: bottom, left, right

`SilkTabs` owns a `TabController`, reports each settled index once, and safely
recreates its controller when item count changes. `SilkTabNavigation` may use a
caller-owned controller. `SilkPillTabBar` intentionally uses compact 3-point
shell and vertical item padding, 10-point horizontal item padding, and 11-point
labels for image-overlay and compact selector contexts.
