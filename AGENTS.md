# Aegis

Flutter **package** (not an app): the design/token/component/icon/asset library for the Athena consumer app. Ships to pub.dev. Not associated with any security "Aegis" — it's a UI kit.

## Environment

- Flutter SDK is pinned via FVM in `.fvmrc` — currently **3.35.7** (same as Athena). Always run Flutter/Dart through `fvm`, never plain `flutter` / `dart`.
- Dart SDK constraint is `>=3.0.0 <4.0.0` (`pubspec.yaml`).
- Lints: `flutter_lints` via `analysis_options.yaml` (no custom rules).
- Versioning of this published package is handled by the release flow — do **not** bump `pubspec.yaml` version by hand, and never rewrite the automated `Release: vX.Y.Z` commits. Commits follow Conventional Commits.

## Commands

Run from the repo root, through `fvm`:

- `fvm flutter pub get` — resolve dependencies.
- `fvm flutter analyze` — static analysis.
- `fvm flutter test` — tests in `test/` (currently just an empty placeholder `test/aegis_test.dart`; there is no meaningful suite to keep green).
- `make build_runner` — regenerate `lib/src/generated/assets.gen.dart` (`AegisAssets`).
- `make icons` — regenerate `lib/fonts/aegis_icons/AegisIcons.ttf` + `lib/src/icons/icons.dart` (`AegisIcons`).
- `fvm flutter run` inside `example/` — the `aegis_app` consumer showcase (separate Flutter app, `publish_to: none`, depends on this package via `path:`).

Generated sources are committed and must be regenerated with the `make` targets, never hand-edited.

## Quick reference

- Public API is reached only through the top-level barrels emitted by `lib/aegis.dart`: `lib/components.dart`, `lib/foundation.dart`, `lib/icons.dart`, `lib/assets.dart`, `lib/utils.dart`. `lib/src/` must never be imported directly.
- Layout: implementation under `lib/src/{components,foundation,icons,utils,generated}`; fonts under `lib/fonts/`; raw assets under `assets/`.
- Components live under `lib/src/components/<area>/` (e.g. `buttons/`, `fields/`, `app_bars/`) with a per-area barrel (e.g. `buttons/buttons.dart`) re-exported from `lib/components.dart`. New public symbols must be exported from the matching domain barrel.
- Naming: widgets/components are `Sk*` (`SkButton`, `SkTextField`), foundation tokens are `Aegis*` (`AegisColors`, `AegisFont`, `AegisIcons`, `AegisAssets`).
- Icons are font glyphs generated from `assets/svg/system/` — `Icon(AegisIcons.arrow_up, color: AegisColors.neutral0)`.
- Asset usage from a dependency context needs explicit `package: 'aegis'` (e.g. `Image.asset(AegisAssets.x.path, package: 'aegis')` or the generated `.image()` extension).
- No CI workflows and no `gen_l10n`/`.arb` files are present.
