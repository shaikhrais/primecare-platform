class StitchScheduling00112Dto {
  final String id;
  final String type;
  final String title;
  final String status;

  StitchScheduling00112Dto.fromJson(Map<String, dynamic> json)
    : id = json['id'] ?? '',
      type = json['type'] ?? '',
      title = json['title'] ?? '',
      status = json['status'] ?? '';
}
