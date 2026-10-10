class BaseNavigationItem<TIcon> {
  final String label;
  final TIcon icon;
  final String route;
  final String? section;
  final TIcon? activeIcon;

  const BaseNavigationItem({
    required this.label,
    required this.icon,
    required this.route,
    this.section,
    this.activeIcon,
  });
}
