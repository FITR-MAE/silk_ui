# Theme

## Colours

### Base Palette

```css
--dark: #141414;
--light: #f5f5f5;
--grey: #595959;

--powder-petal: #ffe5d9;
--cherry-blossom: #f4acb7;
--alabaster-grey: #d8e2dc;
--pastel-pink: #ffcad4;
--dusty-mauve: #9d8189;
```

### Theme Exports

`lib/src/theme/colors.dart` exports a single color token source: `SilkColors`.

Current semantic mapping:

- `SilkColors.primary` -> `dark`
- `SilkColors.secondary` -> `light`
- `SilkColors.disabled` -> `grey`
- `SilkColors.onPrimary` -> `light`
- `SilkColors.onSecondary` -> `dark`
- `SilkColors.surface` -> `light`
- `SilkColors.surfaceDark` -> `dark`
- `SilkColors.outline` -> `cherryBlossom`

## App Theme

`AppTheme.light` and `AppTheme.dark` both use Material 3 and are defined in `lib/src/theme/app_theme.dart`.

### Light Theme

- `primary`: `cherryBlossom`
- `onPrimary`: `dark`
- `secondary`: `powderPetal`
- `onSecondary`: `dark`
- `tertiary`: `dustyMauve`
- `onTertiary`: `light`
- `surface`: `light`
- `onSurface`: `dark`
- `outline`: `cherryBlossom`
- `error`: `dustyMauve`
- `onError`: `light`
- `scaffoldBackgroundColor`: `light`

### Dark Theme

- `primary`: `cherryBlossom`
- `onPrimary`: `light`
- `secondary`: `powderPetal`
- `onSecondary`: `dark`
- `tertiary`: `dustyMauve`
- `onTertiary`: `light`
- `surface`: `dark`
- `onSurface`: `light`
- `outline`: `cherryBlossom`
- `error`: `dustyMauve`
- `onError`: `light`
- `scaffoldBackgroundColor`: `dark`

## Typography

`SilkText` and `SilkTitle` resolve their default text color from theme brightness:

- dark theme -> `SilkColors.light`
- light theme -> `SilkColors.dark`

`SilkSpan` does not apply a theme-aware default color. It uses the provided `color` directly and otherwise leaves color unset.

Use the component `color` property whenever custom text color is needed.

## Button

`SilkButton` variants are defined in `lib/src/components/button/button.dart`.

| Variant   | Border                       | Background                   | Text                         |
| --------- | ---------------------------- | ---------------------------- | ---------------------------- |
| Primary   | `dark`                       | `dark`                       | `light`                      |
| Secondary | `dark`/`light` (theme-based) | `grey` in dark, else transparent | `light`/`dark` (theme-based) |
| Alt       | none                         | `transparent`                | `light`/`dark` (theme-based) |

Disabled buttons use `Theme.of(context).colorScheme.surfaceContainerHighest` for background and border, with reduced opacity.

## Icon Button

`SilkIconButton` extends `SilkButton` and inherits the same variant color behavior.

- default icon color follows the same theme-aware logic as button text
- primary icon color is `light`
- `alt` icon color is theme-based like button text
- icon buttons are square and force `borderRadius: 0`
- inherited non-`alt` borders are `dark` in light theme and `light` in dark theme

## Card

`SilkCard` variants are defined in `lib/src/components/card/card.dart`.

| Variant   | Border                       | Background                   | Text                         |
| --------- | ---------------------------- | ---------------------------- | ---------------------------- |
| Primary   | `dark`/`light` (theme-based) | `transparent`                | `light`/`dark` (theme-based) |
| Secondary | `dark`/`light` (theme-based) | `grey` in dark, else transparent | `light`/`dark` (theme-based) |

## Image

`SilkImage` does not apply theme colors, but it supports `SilkShadow` values of `none`, `sm`, `md`, and `lg`.

## Elevation

Default elevation behavior is flat across the library.

- `SilkButton` defaults to `SilkShadow.none`
- `SilkIconButton` inherits the same flat default from `SilkButton`
- `SilkCard` defaults to `SilkShadow.none`
- `SilkImage` defaults to `SilkShadow.none`

Shadows are opt-in and only appear when a non-`none` `SilkShadow` value is passed.

## Organization

- Shared theme values live in `lib/src/theme/`
- `theme/index.dart` re-exports `app_theme.dart`, `animation.dart`, `border.dart`, `colors.dart`, `spacing.dart`, and `shadow.dart`
- Component-specific variants, scales, and gap helpers live beside their owning components
- Layout primitives live in `lib/src/components/layout/`
- Package root exports both components and theme modules through `lib/silk_ui.dart`
