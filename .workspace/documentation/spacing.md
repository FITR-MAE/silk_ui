# Spacing

## Shared Spacing

Shared spacing primitives live in `lib/src/theme/spacing.dart` as `SilkSpacing`.

Current shared values:

- `SilkSpacing.xs = 8.0`
- `SilkSpacing.sm = 12.0`
- `SilkSpacing.md = 16.0`
- `SilkSpacing.lg = 24.0`

Border primitives live in `lib/src/theme/border.dart` as `SilkBorder`.

- `SilkBorder.width = 0.8`
- `SilkBorder.style = BorderStyle.solid`
- `SilkBorder.radius = 8.0`

Animation primitives live in `lib/src/theme/animation.dart` as `SilkAnimation`.

- `SilkAnimation.duration = Duration(milliseconds: 200)`

## Button Spacing

Button-owned spacing lives in `lib/src/components/button/gap.dart` as `ButtonGap`.

### Content Gap

- `ButtonGap.content = 8.0`

### Vertical Padding By Scale

- `xs = 6.0`
- `sm = 8.0`
- `md = 12.0`
- `lg = 16.0`

### Horizontal Padding By Scale

- `xs = 12.0`
- `sm = 16.0`
- `md = 24.0`
- `lg = 32.0`

`SilkButton` uses these values unless `padding` is passed explicitly.

## Icon Button Spacing

Icon button-owned sizing lives in `lib/src/components/button/gap.dart` as `IconButtonGap`.

### Icon Size By Scale

- `xs = 16.0`
- `sm = 20.0`
- `md = 24.0`
- `lg = 28.0`

### Square Side Length By Scale

- `xs = 28.0`
- `sm = 36.0`
- `md = 48.0`
- `lg = 56.0`

`SilkIconButton` applies `EdgeInsets.zero` and uses fixed square constraints from `IconButtonGap.side(scale)`.

## Card Spacing

Card-owned spacing lives in `lib/src/components/card/gap.dart` as `CardGap`.

### Padding By Scale

- `xs = 8.0`
- `sm = 12.0`
- `md = 16.0`
- `lg = 24.0`

`SilkCard` uses these values unless a custom `padding` is passed.

## Border Radius Usage

Shared `SilkBorder.radius` is currently used by:

- `SilkButton` as the default `borderRadius`
- `SilkCard` as the default `borderRadius`

`SilkImage` manages its own `borderRadius` directly and defaults to `0.0`.

## Animation

`SilkButton` uses `SilkAnimation.duration` for its `AnimatedOpacity` transition.

## Default Elevation

Default app behavior is flat.

- `SilkButton` has no shadow unless `shadow` is set
- `SilkIconButton` has no shadow unless `shadow` is set on the inherited button API
- `SilkCard` has no shadow unless `shadow` is set
- `SilkImage` has no shadow unless `shadow` is set

## Layout Values

`SilkGrid` and `SilkStack` both support preset values of `sm`, `md`, and `lg`.

### GridValue

- `sm = SilkSpacing.xs`
- `md = SilkSpacing.md`
- `lg = SilkSpacing.lg`

`GridValue` drives default:

- `mainAxisSpacing`
- `crossAxisSpacing`
- outer `padding`

Explicit `mainAxisSpacing`, `crossAxisSpacing`, or `padding` still override the preset.

### StackValue

- `sm = SilkSpacing.xs`
- `md = SilkSpacing.md`
- `lg = SilkSpacing.lg`

`StackValue` drives spacing between children.

`SilkStack` supports `StackOrientation.vertical` and `StackOrientation.horizontal`, and defaults to vertical.
