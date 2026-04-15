# Theme

## Colours

### Base Palette

```css
--dark: #141414;
--light: #f5f5f5;
--grey: #595959;
--destructive: #dc2626;

--powder-petal: #ffe5d9;
--cherry-blossom: #f4acb7;
--alabaster-grey: #d8e2dc;
--pastel-pink: #ffcad4;
--dusty-mauve: #9d8189;
```

### Theme Exports

`lib/src/theme/colors.dart` exports a single source of truth: `SilkColors`.

- `SilkColors.primary -> dark`
- `SilkColors.secondary -> light`
- `SilkColors.disabled -> grey`
- `SilkColors.onPrimary -> light`
- `SilkColors.onSecondary -> dark`
- `SilkColors.surface -> light`
- `SilkColors.surfaceDark -> dark`
- `SilkColors.outline -> cherryBlossom`
- `SilkColors.destructive -> #DC2626`

## App Theme

`AppTheme.light` and `AppTheme.dark` are defined in `lib/src/theme/app_theme.dart` and use Material 3.

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

## Component Colour Behavior

### Button

| Variant | Border | Background | Text |
| --- | --- | --- | --- |
| Primary | `dark` | `dark` | `light` |
| Secondary | theme-aware | `transparent` in light, `grey` in dark | theme-aware |
| Alt | none | `transparent` | theme-aware |

Disabled buttons use `Theme.of(context).colorScheme.surfaceContainerHighest` for background and border.

### Card

| Variant | Border | Background | Text |
| --- | --- | --- | --- |
| Primary | theme-aware | `transparent` | theme-aware |
| Secondary | theme-aware | `transparent` in light, `grey` in dark | theme-aware |

### Tabs and Navigation

- `SilkTabNavigation` uses a themed container with a dark active tab
- `SilkTabs` uses themed surfaces for `pill` style, dark active fill for `button` style, and theme-aware borders for `outline` style

### Badge

| Variant | Background | Text |
| --- | --- | --- |
| Primary | `dark` | `light` |
| Secondary | `light` in light theme, `grey` in dark theme | theme-aware |
| Destructive | `destructive` | `light` |
| Outline | `transparent` | theme-aware |

### Text

- `SilkText` and `SilkTitle` default to `dark` text in light theme and `light` text in dark theme
- `SilkSpan` only applies a color when one is provided
