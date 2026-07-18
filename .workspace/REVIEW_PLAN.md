# Codebase Review Plan

Reviewed on 2026-07-18 against the package source, public API, tests, lume
consumer, current Flutter analyzer, and the latest stable package releases.

## Product Direction

Keep Silk image-first and content-led. VSCO and Instagram provide useful
reference points: restrained chrome, predictable media grids, direct camera
controls, compact typography, and navigation that stays out of the content.
Silk should retain its warm neutral palette and indigo accent rather than copy
either product.

## P0: Correctness and Consumer Compatibility

- [x] Update all direct dependencies to their latest stable releases.
- [ ] Restore the navigation and camera API used by the lume consumer.
- [ ] Serialize camera open/close transitions and guard stale async work.
- [ ] Deliver successful captures even when camera-roll persistence fails.
- [ ] Stop requesting photo-library permission when camera controls mount.
- [x] Fix duplicate `SilkTabs.onChanged` callbacks and honor tab padding.
- [ ] Handle navigation controller and item-count changes safely.

## P1: Internal UI Consistency

- [ ] Resolve all component colors through `SilkColorScheme`.
- [x] Fix primary icon contrast in dark mode.
- [x] Treat missing button callbacks as disabled state.
- [x] Make cards clip content and show ink feedback correctly.
- [x] Use distinct 4-point-grid values for every layout gap preset.
- [ ] Correct navigation safe-area spacing and keep shadows opt-in.
- [ ] Apply camera rounding consistently to loading, error, and live states.
- [ ] Add semantics and keyboard-capable interaction to custom controls.

## P2: Maintenance and Coverage

- [ ] Remove unreferenced internal image button and thumbnail implementations.
- [ ] Remove unused members and hide internal layout helpers from the barrel API.
- [ ] Add behavioral tests for tabs, navigation, camera controls, dark mode,
      semantics, narrow layouts, and reduced motion.
- [ ] Reconcile README and workspace token/API documentation with shipped code.
- [ ] Replace template package metadata and changelog placeholders.
- [ ] Analyze the lume consumer against each public API batch.

## Verification Gate

Every batch must pass `dart format lib test`, `flutter analyze`, and the
relevant focused tests. The final state must pass the full `flutter test` suite,
`flutter pub outdated`, `git diff --check`, and lume app analysis.
