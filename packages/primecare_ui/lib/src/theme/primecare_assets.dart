/// Shared package asset keys. SVG rendering is supplied by each app.
abstract final class PrimeCareAssets {
  static const packageName = 'primecare_ui';
  static const root = 'packages/primecare_ui/assets/original';
  static const iconNames = <String>[
    'dashboard',
    'menu',
    'search',
    'home',
    'calendar',
    'clock',
    'user',
    'team',
    'tenant',
    'territory',
    'pin',
    'phone',
    'message',
    'email',
    'video',
    'microphone',
    'notification',
    'settings',
    'theme',
    'layout',
    'sun',
    'moon',
    'add',
    'close',
    'check',
    'edit',
    'delete',
    'download',
    'upload',
    'filter',
    'more',
    'arrow-right',
    'chevron-down',
    'refresh',
    'lock',
    'shield',
    'logout',
    'help',
    'info',
    'warning',
    'heart',
    'pulse',
    'care-plan',
    'medical-bag',
    'accessibility',
    'appointment',
    'report',
    'billing',
    'folder',
    'image',
    'audit',
    'workflow',
    'cloud',
    'link',
    'star',
    'save',
  ];
  /// Full bundle key for rootBundle.loadString or an SVG renderer.
  static String icon(String name) {
    if (!iconNames.contains(name)) throw ArgumentError.value(name, 'name', 'Unknown PrimeCare icon');
    return '$root/icons/$name.svg';
  }
  static const brandMark = '$root/assets/brand-mark-concept.svg';
  static const backgroundGrid = '$root/assets/background-grid.svg';
  static const backgroundOrbit = '$root/assets/background-orbit.svg';
  static const emptyAppointments = '$root/assets/empty-appointments.svg';
  static const emptyMessages = '$root/assets/empty-messages.svg';
  static const emptySearch = '$root/assets/empty-search.svg';
  static const emptyRecords = '$root/assets/empty-records.svg';
  static const themeTokens = '$root/theme-tokens.json';
}
