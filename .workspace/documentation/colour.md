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
| cardForeground | `#1C1917` | `#FAFAF9` |
| muted | `#F5F5F4` | `#292524` |
| mutedForeground | `#78716C` | `#A8A29E` |
| border | `#E7E5E4` | `#292524` |
| input | `#D6D3D1` | `#44403C` |
| ring | `#4F46E5` | `#818CF8` |
| primary | `#1C1917` | `#FAFAF9` |
| primaryForeground | `#FAFAF9` | `#1C1917` |
| secondary | `#F5F5F4` | `#292524` |
| secondaryForeground | `#1C1917` | `#FAFAF9` |
| accent | `#4F46E5` | `#818CF8` |
| accentForeground | `#FFFFFF` | `#1C1917` |
| destructive | `#DC2626` | `#DC2626` |
| destructiveForeground | `#FFFFFF` | `#FFFFFF` |
| success | `#16A34A` | `#22C55E` |
| successForeground | `#0C0A09` | `#0C0A09` |
| warning | `#D97706` | `#FBBF24` |
| shadowColor | `#0A000000` | `#20000000` |
| scrim | `#66000000` | `#99000000` |

Interaction overlays are derived from semantic tokens: `hoverOverlay` uses
`accent` at 8% opacity and `focusOverlay` uses `ring` at 16% opacity. Components
resolve both from the installed `SilkColorScheme`, including copied schemes.

Camera controls intentionally use black and white overlays so they remain
legible over arbitrary media.

Success badges use the near-black `successForeground`; destructive badges use
white over `#DC2626` in both themes to preserve small-text contrast. Consumers
may install a copied `SilkColorScheme` in their own themes, but components must
still resolve colors from the extension instead of branching on brightness.
