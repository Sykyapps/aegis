enum AegisScreens {
  home('/'),
  styles('/styles'),
  icons('/styles/icons'),
  components('/components'),
  appBars('/components/app-bars'),
  basicAppBar('/components/app-bars/basic'),
  sliverAppBar('/components/app-bars/sliver'),
  buttons('/components/buttons'),
  fields('/components/fields'),
  sheets('/components/sheets'),
  tabs('/components/tabs');

  final String path;

  const AegisScreens(this.path);
}
