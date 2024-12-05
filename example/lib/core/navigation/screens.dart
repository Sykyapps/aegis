enum AegisScreens {
  home('/'),
  styles('/styles'),
  icons('/styles/icons'),
  components('/components'),
  buttons('/components/buttons'),
  fields('/components/fields'),
  sheets('/components/sheets'),
  tabs('/components/tabs');

  final String path;

  const AegisScreens(this.path);
}
