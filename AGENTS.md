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

## Known state

`flutter analyze` and `flutter test` are expected to pass. Camera tests account
for the 250ms open debounce and inject `availableCamerasLoader`.

## Icon set

`phosphor_flutter` was removed (incompatible with Flutter 3.44 — `IconData` is now `final` and cannot be extended). `SilkIcon`, `SilkIconButton`, and `SilkCameraControl` use Material `IconData` / `Icon`. When adding icon props, type them as `IconData` and pass `Icons.*` constants — do not reintroduce Phosphor.

## Public API boundary

`lib/silk_ui.dart` is the single barrel file and the entire public surface. **Classes that exist in `lib/src/` but are NOT exported from the barrel are internal-only**, even though they're not private (`_`-prefixed). Notably unexported:

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

- **Theme = single source of truth.** All design tokens live in `lib/src/theme/` and are re-exported via `theme/index.dart`. `SilkColorScheme` is the canonical theme-aware color source; components resolve it with `SilkColorScheme.of(context)`. `SilkColors` contains legacy light constants and intentional media-overlay colors.
- **Flat by default.** Every component defaults to `SilkShadow.none`; shadows are opt-in via a `shadow` prop. Don't add elevation by default.
- **Component pattern.** Each component dir has co-located sizing helpers where needed. Sizing uses component-owned enums (`ButtonScale`, `CardScale`, `TextScale`, `TitleScale`, `BadgeScale`, `GridValue`, `StackGap`) that map to shared tokens. Follow this layout for new components — don't inline magic numbers.
- **`SilkCamera` is a complex async state machine** (`lib/src/components/camera/camera.dart`): serialized debounced open/close transitions, monotonic `_openRequestId` race guards, `WidgetsBindingObserver` lifecycle handling, and optional camera-roll persistence via `photo_manager`. It accepts an injectable `availableCamerasLoader` (defaults to `availableCameras()`). Camera tests **must inject** this loader — do not access real camera hardware.
- Code uses modern Dart null-aware element syntax, e.g. `if (leading case final leading?) leading,` inside collection literals. Match that style; `flutter analyze` will flag the older `if (x != null)` form as `use_null_aware_elements`.

## Reference docs

`.workspace/WORKSPACE.md` and `.workspace/documentation/*.md` (`colour.md`, `spacing.md`, `typography.md`, `shadow.md`, `scale.md`) are the design spec. Consult these when changing theme tokens or component variants and keep `README.md` synchronized with the barrel API.

## Conventions

- Commits use Conventional Commits prefixes (`feat:`, `fix:`), lowercase, imperative mood (see `git log`). Match this.
- `lib/` is the shipped code; `test/` mirrors component names (`button_test.dart`, `camera_test.dart`, ...). Widget tests wrap components in `MaterialApp`/`Scaffold` and assert on `Material`, `Container`, `Text` descendants.
- **Keep documentation in sync.** When making code changes, update the
  corresponding documentation — AGENTS.md files, READMEs, and
  workspace `documentation/` — so references stay accurate.

## Consumers

silk_ui is shared by the **lume** Flutter app (`../lume/packages/app/`) and the
**Fitr** Flutter app (`../fitr_flutter_frontend/`). Lume depends on silk_ui via a
relative path in its `pubspec.yaml`:

```yaml
silk_ui:
  path: ../silk_ui
```

In the workspace layout, silk_ui lives at the workspace root, not inside lume.
A symlink is needed for the lume app to resolve it:

```bash
ln -s ../../../silk_ui lume/packages/silk_ui
```

Fitr consumes `FITR-MAE/silk_ui` from the `development` branch as a Git
dependency. Changes must be pushed to `origin/development`, then resolved in
Fitr with `flutter pub get`, before Fitr can pick them up. Lume uses the local
path directly.

### Cross-project reference docs

| File | Use |
|---|---|
| `../documentation/system-architecture.md` | Full architecture diagram, data flow |
| `../lume/packages/app/AGENTS.md` | Flutter app conventions (the consumer of this library) |
| `../lume/AGENTS.md` | lume TS workspace guide (API that the app calls) |
