# Colour

## Source Of Truth

`SilkColorScheme` is a `ThemeExtension` registered by `AppTheme.light` and
`AppTheme.dark`. Components use `SilkColorScheme.of(context)`. `SilkColors`
contains legacy light-palette constants and media overlays only.

## Core Palettes

| Token | Light | Dark |
| --- | --- | --- |
| background | `#FAFAF9` | `#0C0A09` |
| foreground | `#1C1917` | `#FAFAF9` |
| card | `#FFFFFF` | `#1C1917` |
| muted | `#F5F5F4` | `#292524` |
| mutedForeground | `#78716C` | `#A8A29E` |
| border | `#E7E5E4` | `#292524` |
| primary | `#1C1917` | `#FAFAF9` |
| primaryForeground | `#FAFAF9` | `#1C1917` |
| accent | `#4F46E5` | `#818CF8` |
| destructive | `#DC2626` | `#EF4444` |
| success | `#16A34A` | `#22C55E` |
| warning | `#D97706` | `#FBBF24` |

Camera controls intentionally use black and white overlays so they remain
legible over arbitrary media.

Success badges use the near-black `successForeground`; destructive badges use
white over `#DC2626` in both themes to preserve small-text contrast.
