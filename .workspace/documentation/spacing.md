# Spacing

## Canonical Grid

`SilkSpacing` is the source of truth: `s0=0`, `s1=4`, `s2=8`, `s3=12`,
`s4=16`, `s5=20`, `s6=24`, `s8=32`, `s10=40`, `s12=48`, `s16=64`,
`s20=80`, and `s24=96`.

`SilkGap` and `SilkSpacing.xs/sm/md/lg` are compatibility aliases. New code
uses the canonical `s*` values.

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
