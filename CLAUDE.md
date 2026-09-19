# silk_ui

## Overview
`silk_ui` is the shared Flutter component library for the Fitr ecosystem. It is maintained by Elias under `FITR-MAE/silk_ui` and consumed by:
- `fitr_app` (the main Flutter app at `C:\Users\17802\Documents\GitHub\fitr_app`) — via git dependency
- `fitr-ui-demo` (the Figma-to-code prototype repo)

When working here, assume any change ripples into downstream apps. Cross-reference `fitr_app/CLAUDE.md` for how components are consumed in practice.

## Package Structure
```
lib/
  silk_ui.dart              # public barrel — only what's exported here is importable downstream
  src/
    components/
      avatar/     avatar.dart
      badge/      badge.dart
      button/     button.dart, icon_button.dart, img_button.dart
      camera/     camera.dart, camera_control.dart, camera_viewfinder.dart
      card/       card.dart
      chip/       filter_chip.dart, hashtag.dart, toggle_chip.dart
      icon/       icon.dart
      img/        img.dart, thumbnail.dart   # thumbnail.dart NOT exported
      input/      input.dart
      layout/     grid.dart, stack.dart, tab_view.dart
      navigation/ drawer.dart, tab_navigation.dart
      skeleton/   skeleton.dart
      tabs/       pill_tab_bar.dart
      text/       span.dart, text.dart, title.dart
    theme/        app_theme.dart, animation.dart, border.dart, colors.dart,
                  gap.dart, spacing.dart, shadow.dart, typography.dart
```

Each component folder sometimes contains a `gap.dart` — local layout tokens scoped to that component (e.g. `ButtonGap.paddingVertical(scale)`).

## Public API (silk_ui.dart exports)
- **Widgets**: `SilkAvatar`, `SilkBadge`, `SilkButton`, `SilkIconButton`, `SilkCamera` + controls, `SilkCard`, `SilkFilterChip`, `SilkHashtag`, `SilkToggleChip`, `SilkIcon`, `SilkImage`, `SilkInput`, `SilkGrid`, `SilkStack`, `SilkTabView`, `SilkDrawer`, `SilkTabNavigation`, `SilkSkeleton`, `SilkPillTabBar`, `SilkSpan`, `SilkText`, `SilkTitle`
- **Theme**: `SilkColors`, `SilkSpacing`, `SilkTypography`, `SilkBorder`, `SilkShadow`, `SilkAnimation`, app theme
- **NOT exported**: `SilkThumbnail` (in `img/thumbnail.dart`). `fitr_app` needs this — add it to `silk_ui.dart` when ready to ship.

## Theme Tokens
**SilkColors** (`src/theme/colors.dart`):
- Base: `dark`, `light`, `grey`, `destructive`
- UI: `muted`, `mutedForeground`, `accent`, `border`, `inputBackground`, `switchBackground`
- Brand: `powderPetal`, `cherryBlossom`, `alabasterGrey`, `pastelPink`, `dustyMauve`
- Aliases: `primary` = dark, `secondary` = muted, `onPrimary` = light, `surface` = light, `outline` = border

**SilkTypography**: Inter font. Sizes `xs:10, sm:12, md:16, lg:18, xl:20, xxl:24`. Weights `normal:400, medium:500, semibold:600, bold:700`.

**SilkSpacing**: `xs:1, sm:2, md:4, lg:8`. Also icon-button sizing tokens (`iconButtonIconXs..Lg`, `iconButtonSideXs..Lg`).

## Common Component Patterns
- **Variants via enums**: `ButtonVariant { primary, secondary, alt }`, `ButtonScale { xs, sm, md, lg }`, `PillTabStyle { light, dark, outlined }`. Follow this pattern when adding new variants.
- **Shadow opt-in**: most surface components take a `SilkShadow` enum (`none, xs, sm, md, lg`) and resolve it via `_shadowConfig`.
- **Border radius**: defaults from `SilkBorder.radiusDefault`, overridable per instance.
- **Dark mode**: components check `Theme.of(context).brightness` to pick foreground/border colors. New components should do the same rather than hardcoding colors.

## Working in this Repo
- `flutter pub get` to install deps
- `flutter analyze` and `flutter test` before pushing
- Bump `version:` in `pubspec.yaml` for any public API change — downstream apps pin by git ref, so version bumps signal breaking vs additive changes
- Dependencies: `phosphor_flutter` (icons), `camera` + `camera_android` + `photo_manager` (camera components). `camera_android_camerax` is null-overridden in `pubspec.yaml`.

## Downstream Context (fitr_app)
`fitr_app/CLAUDE.md` tracks which silk_ui widgets it has migrated to. As of its last update, it believed several widgets/tokens didn't yet exist upstream — but they do:
- `SilkPillTabBar`, `SilkHashtag`, `SilkFilterChip`, `SilkToggleChip` — all exist and are exported
- `SilkColors.accent/muted/mutedForeground/border` — all exist

The real outstanding gap from fitr_app's perspective:
- `SilkThumbnail` — exists in the repo but not re-exported from `silk_ui.dart`. Add the export.

Fitr-specific widgets that fitr_app has built locally and wants upstreamed: `SuggestionChip` (outlined AI-chat suggestion chip), `StyleTag` (selectable tag with checkmark — may already overlap with `SilkBadge`).

## Adding a New Component — Checklist
1. Create folder under `lib/src/components/<name>/` with the main `.dart` file (plus `gap.dart` if it has local spacing tokens).
2. Use `SilkColors` / `SilkTypography` / `SilkSpacing` / `SilkBorder` / `SilkShadow` — never hardcode values.
3. Support dark mode via `Theme.of(context).brightness`.
4. Expose variants through enums, not booleans (`variant: ButtonVariant.primary`, not `isPrimary: true`).
5. Add the export to `lib/silk_ui.dart`.
6. Write a widget test under `test/`.
7. Bump `pubspec.yaml` version.
