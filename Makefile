# Aegis

### Development task

# Generating icon font
icons:
	fvm flutter pub run icon_font_generator --from=lib/assets/svg/system --class-name=AegisIcons --out-font=lib/fonts/aegis_icons/AegisIcons.ttf --out-flutter=lib/src/icons/icons.dart --package=aegis --height=1024 --descent=6400 --normalize
	
icons-dev:
	fvm flutter pub run icon_font_generator --from=lib/assets/svg/system --class-name=AegisIconsDev --out-font=lib/fonts/aegis_icons/AegisIconsDev.ttf --out-flutter=lib/src/icons/icons_dev.dart --package=aegis --height=1024 --descent=6400 --normalize
