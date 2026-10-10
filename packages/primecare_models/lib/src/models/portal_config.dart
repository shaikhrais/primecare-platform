class PortalConfig {
  final String title;
  final String brandingName;
  final bool isPlain;

  const PortalConfig({
    required this.title,
    required this.brandingName,
    this.isPlain = true,
  });
}
