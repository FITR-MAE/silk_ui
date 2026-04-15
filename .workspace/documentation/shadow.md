# Shadow

## Shared Shadow Tokens

Defined in `lib/src/theme/shadow.dart`.

- `SilkShadow.none`
- `SilkShadow.xs`
- `SilkShadow.sm`
- `SilkShadow.md`
- `SilkShadow.lg`

## ShadowConfig

- `ShadowConfig.none = elevation 0`
- `ShadowConfig.xs = elevation 1, color 0x14000000`
- `ShadowConfig.sm = elevation 2, color 0x1A000000`
- `ShadowConfig.md = elevation 4, color 0x29000000`
- `ShadowConfig.lg = elevation 8, color 0x3D000000`

## Default Behavior

The library is flat by default.

- `SilkButton` defaults to `SilkShadow.none`
- `SilkIconButton` defaults to `SilkShadow.none`
- `SilkCard` defaults to `SilkShadow.none`
- `SilkImage` defaults to `SilkShadow.none`
- `SilkTabNavigation`, `SilkTabs`, `SilkBadge`, and `SilkDrawer` currently render flat by default

Shadows are opt-in where a component exposes a `SilkShadow` prop.
