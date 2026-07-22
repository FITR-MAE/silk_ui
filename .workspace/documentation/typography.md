# Typography

## Tokens

- Sizes: xxs `10`, xs `12`, sm `14`, md `16`, lg `18`, xl `20`, xxl `24`,
  xxxl `30`, display `36`
- Weights: normal `400`, medium `500`, semibold `600`, bold `700`
- Line heights: tight `1.2`, snug `1.35`, normal `1.5`, relaxed `1.625`
- Tracking: tight `-0.3`, normal `0`, wide `0.2`

## Components

- `TextScale.xs/sm/md/lg` maps to `12/14/16/18`; the first two use `1.5`
  line height and the latter two use `1.625`.
- `TitleScale.h1/h2/h3` maps to `30/24/20`; h1 is bold with tight tracking,
  while h2 and h3 are semibold with normal tracking. All use `1.2` line height.
- Button and navigation labels use compact semibold styles.
- `AppTheme` supplies a complete Material `TextTheme`; platform fallbacks are
  used when SF Pro is unavailable.
