class FeatureViewModel {
  final String id;
  final String title;
  final String status;
  final String description;
  final String type;
  final Map<String, dynamic>
  rawPayload; // Catch-all for specialized widgets until strictly typed

  FeatureViewModel({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.type,
    required this.rawPayload,
  });
}
