# Aegis

### Development task

# Generating icon font
icons:
	fvm dart run icon_font_generator --from=assets/svg/system --class-name=AegisIcons --out-font=lib/fonts/aegis_icons/AegisIcons.ttf --out-flutter=lib/src/icons/icons.dart --package=aegis --height=1024 --descent=64 --normalize

# Run build_runner
build_runner: 
	fvm dart run build_runner build --delete-conflicting-outputs