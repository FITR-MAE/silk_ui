# Spacing

## Canonical Grid

`SilkSpacing` is the source of truth: `s0=0`, `s1=4`, `s2=8`, `s3=12`,
`s4=16`, `s5=20`, `s6=24`, `s8=32`, `s10=40`, `s12=48`, `s16=64`,
`s20=80`, and `s24=96`.

New code uses the canonical `s*` values. `SilkGap` is deprecated but retains its
old `4/8/12/16/20/24/32` aliases. The legacy `SilkSpacing.xs/sm/md/lg` values
are `1/2/4/8`; do not use them as aliases for the canonical grid.

## Borders

- Widths: hairline `0.25`, default `0.5`, medium `1.0`
- Radii: none `0`, xs `2`, sm `4`, md `6`, lg `10`, xl `14`, 2xl `18`,
  3xl `22`, round `999`

## Layout Presets

`GridValue` and `StackGap` map `xs/sm/md/lg` to `4/8/12/16`. Grid outer
padding defaults to `4`; callers can remove it for edge-to-edge media grids.

Navigation uses 16-point side margins, 12-point bottom margin, 4-point inner
padding, and the device bottom safe area. Drawer width is 75% of the viewport,
capped at 420 points.

## Interaction Sizing

- Button content padding scales from `12x6` to `24x16`, but every button keeps
  a minimum 44-point interactive dimension.
- Icon artwork scales through `16/20/24/28`; icon-button visual sides are
  `28/36/48/56` and the first two retain a 44-point hit target.
- Filter chips, toggle chips, pill-tab items, navigation items, and tappable
  avatars use minimum 44-by-44 interaction targets. Compact chip, tab, and
  avatar artwork is centered inside transparent target geometry.
