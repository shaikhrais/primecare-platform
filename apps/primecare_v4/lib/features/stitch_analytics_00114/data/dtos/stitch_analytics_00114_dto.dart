class StitchAnalytics00114Dto {
  final String id;
  final String type;
  final String title;
  final String status;

  StitchAnalytics00114Dto.fromJson(Map<String, dynamic> json)
    : id = json['id'] ?? '',
      type = json['type'] ?? '',
      title = json['title'] ?? '',
      status = json['status'] ?? '';
}
