class StitchAnalytics00126Dto {
  final String id;
  final String type;
  final String title;
  final String status;

  StitchAnalytics00126Dto.fromJson(Map<String, dynamic> json)
    : id = json['id'] ?? '',
      type = json['type'] ?? '',
      title = json['title'] ?? '',
      status = json['status'] ?? '';
}
