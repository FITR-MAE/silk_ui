# AGENTS.md

Notes for OpenCode sessions working in `silk_ui`. Verify commands against the current toolchain before trusting them.

## Project type

- Flutter **package** (reusable UI library), not an app. `.metadata` → `project_type: package`. There is no runnable app target.
- `pubspec.lock` is gitignored (library convention). Dependency versions are not pinned in-repo, so always run `flutter pub get` on first touch; resolved versions may drift from whatever was last committed.
- Toolchain on this machine: Dart 3.12.2 / Flutter 3.44.3 (stable). `pubspec.yaml` declares `sdk: ^3.11.4`.

## Commands

```bash
flutter pub get                 # required first; no lockfile committed
dart format lib test             # formatter; format before committing
flutter analyze                  # static analysis (flutter_lints ^6.0.0)
flutter test                     # run all widget tests
flutter test test/button_test.dart                  # one file
flutter test --plain-name "renders with label" test/button_test.dart   # one test by name
```

Suggested order when finishing a change: `dart format` → `flutter analyze` → `flutter test`.

## Known broken state (read this before debugging test failures)

`flutter test` runs (71 of 72 pass). One pre-existing failure:

- `test/camera_test.dart` → `SilkCamera renders custom error widget when initialization fails` — the test calls `pumpAndSettle()` but `SilkCamera._syncCameraState` opens the camera through a 250ms debounce `Timer` (`_openDebounceDelay`), so `_openCamera` never runs within the test and `_hasError` is never set. This is a test timing bug, not a library bug. Don't "fix" the library to make it green; fix the test (e.g. `pump(Duration(milliseconds: 250))` before `pumpAndSettle()`).

`flutter analyze` on `lib/` passes with 3 info-level `use_null_aware_elements` lints at `lib/src/components/button/button.dart:175-177`.

`pubspec.yaml` has `dependency_overrides: camera_android_camerax: null`, which nulls a transitive dep to keep `camera`/`camera_android` resolving. Leave it unless you understand why it's there.

## Icon set

`phosphor_flutter` was removed (incompatible with Flutter 3.44 — `IconData` is now `final` and cannot be extended). `SilkIcon`, `SilkIconButton`, `SilkImgButton`, and `SilkCameraControl` all use Material `IconData` / `Icon` now. When adding icon props, type them as `IconData` and pass `Icons.*` constants — do not reintroduce Phosphor.

## Public API boundary

`lib/silk_ui.dart` is the single barrel file and the entire public surface. **Classes that exist in `lib/src/` but are NOT exported from the barrel are internal-only**, even though they're not private (`_`-prefixed). Notably unexported:

- `SilkImgButton` (`lib/src/components/button/img_button.dart`) — used internally by the camera gallery button
- `SilkThumbnail` (`lib/src/components/img/thumbnail.dart`)
- `SilkCameraControl` and `SilkCameraViewfinder` (`lib/src/components/camera/`) — internal parts of `SilkCamera`
- `SilkDrawer.show(...)` is public (drawer.dart is exported), but its `_DrawerDialog` impl is private

When adding a component, export it from `lib/silk_ui.dart` only if it's meant to be public. Don't expand the barrel casually.

### `SilkTabNavigation` controller

`SilkTabNavigation` accepts an optional `TabController? controller`. When
provided, the caller owns the controller (creates, listens, disposes). This lets
consumers like the lume `TabNavigationShell` programmatically animate between
tabs. If no controller is passed, `SilkTabNavigation` creates and manages one
internally as before.

## Architecture notes

- **Theme = single source of truth.** All design tokens live in `lib/src/theme/` (`colors.dart`, `spacing.dart`, `gap.dart`, `border.dart`, `shadow.dart`, `typography.dart`, `animation.dart`) as static constants, re-exported via `theme/index.dart`. `SilkColors` is the canonical color source; `AppTheme.light`/`AppTheme.dark` (Material 3) in `app_theme.dart` are the only `ThemeData` builders. Components resolve theme-aware colors at runtime via `Theme.of(context).brightness == Brightness.dark`, **not** from `AppTheme` directly.
- **Flat by default.** Every component defaults to `SilkShadow.none`; shadows are opt-in via a `shadow` prop. Don't add elevation by default.
- **Component pattern.** Each component dir has a co-located `gap.dart` with sizing/padding helpers (e.g. `lib/src/components/button/gap.dart`). Sizing uses component-owned enums (`ButtonScale`, `CardScale`, `TextScale`, `TitleScale`, `BadgeScale`, `GridValue`, `StackValue`) that map to the shared tokens. Follow this layout for new components — don't inline magic numbers.
- **`SilkCamera` is a complex async state machine** (`lib/src/components/camera/camera.dart`): debounced open/close, monotonic `_openRequestId` to race-guard async ops, `WidgetsBindingObserver` for app lifecycle, saves captures to the camera roll via `photo_manager`. It accepts an injectable `availableCamerasLoader` (defaults to `availableCameras()`). Camera tests **must inject** this loader (see `test/camera_test.dart`) — do not let tests call real camera hardware.
- Code uses modern Dart null-aware element syntax, e.g. `if (leading case final leading?) leading,` inside collection literals. Match that style; `flutter analyze` will flag the older `if (x != null)` form as `use_null_aware_elements`.

## Reference docs

`.workspace/WORKSPACE.md` and `.workspace/documentation/*.md` (`colour.md`, `spacing.md`, `typography.md`, `shadow.md`, `scale.md`) are the design spec: exact token values, variant tables, and per-component sizing rules. Consult these when changing theme tokens or component variants — they are the source of truth for intended values. `README.md` is still the Flutter package template (TODOs); ignore it as a description source.

## Conventions

- Commits use Conventional Commits prefixes (`feat:`, `fix:`), lowercase, imperative mood (see `git log`). Match this.
- `lib/` is the shipped code; `test/` mirrors component names (`button_test.dart`, `camera_test.dart`, ...). Widget tests wrap components in `MaterialApp`/`Scaffold` and assert on `Material`, `Container`, `Text` descendants.
- **Keep documentation in sync.** When making code changes, update the
  corresponding documentation — AGENTS.md files, READMEs, and
  workspace `documentation/` — so references stay accurate.

## Consumer: lume app

silk_ui is the UI component library for the **lume** Flutter app
(`../lume/packages/app/`). The lume app depends on silk_ui via a relative path
in its `pubspec.yaml`:

```yaml
silk_ui:
  path: ../silk_ui
```

In the workspace layout, silk_ui lives at the workspace root, not inside lume.
A symlink is needed for the lume app to resolve it:

```bash
ln -s ../../../silk_ui lume/packages/silk_ui
```

Changes to silk_ui must be pushed to `origin/development` before the lume app
can pick them up — lume consumes it by path, not git revision.

### Cross-project reference docs

| File | Use |
|---|---|
| `../documentation/system-architecture.md` | Full architecture diagram, data flow |
| `../lume/packages/app/AGENTS.md` | Flutter app conventions (the consumer of this library) |
| `../lume/AGENTS.md` | lume TS workspace guide (API that the app calls) |