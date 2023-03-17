enum AegisScreen {
  home,
  button,
  fields,
  card,
  bottomsheet,
  chip,
  segmentedControl
}

extension AegisScreenX on AegisScreen {
  String get path {
    switch (this) {
      case AegisScreen.home:
        return '/';
      case AegisScreen.bottomsheet:
        return '/bottomsheet';
      case AegisScreen.segmentedControl:
        return '/segmented-control';
      case AegisScreen.fields:
        return '/field';
      default:
        return '/';
    }
  }

  String get name {
    switch (this) {
      case AegisScreen.home:
        return 'home';
      case AegisScreen.bottomsheet:
        return 'bottomsheet';
      case AegisScreen.segmentedControl:
        return 'segmentedControl';
      case AegisScreen.fields:
        return 'field';
      default:
        return 'home';
    }
  }

  String get title {
    switch (this) {
      case AegisScreen.home:
        return 'Home';
      case AegisScreen.bottomsheet:
        return 'Bottom Sheet';
      case AegisScreen.segmentedControl:
        return 'Segmented Control';
      case AegisScreen.fields:
        return 'Fields';
      default:
        return '';
    }
  }
}
