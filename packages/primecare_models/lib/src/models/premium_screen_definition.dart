/// Canonical screen metadata; shared by API metadata producers and UI adapters.
class PremiumScreenDefinition {
  final String title;
  final String modelName;
  final String apiPath;
  final String keyPrefix;
  const PremiumScreenDefinition({
    required this.title,
    required this.modelName,
    required this.apiPath,
    required this.keyPrefix,
  });
}
