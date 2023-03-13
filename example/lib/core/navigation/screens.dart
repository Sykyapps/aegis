enum AegisScreen {
  home,
  button,
  field,
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
      default:
        return '';
    }
  }
}
