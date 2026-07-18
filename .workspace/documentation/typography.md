# Typography

## Tokens

- Sizes: xxs `10`, xs `12`, sm `14`, md `16`, lg `18`, xl `20`, xxl `24`,
  xxxl `30`, display `36`
- Weights: normal `400`, medium `500`, semibold `600`, bold `700`
- Line heights: tight `1.2`, snug `1.35`, normal `1.5`, relaxed `1.625`

## Components

- `TextScale.xs/sm/md/lg` maps to `12/14/16/18`.
- `TitleScale.h1/h2/h3` maps to `30/24/20` with bold or semibold weight.
- Button and navigation labels use compact semibold styles.
- `AppTheme` supplies a complete Material `TextTheme`; platform fallbacks are
  used when SF Pro is unavailable.
