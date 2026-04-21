// Layer: 02_MODELS_FOUNDATION
class QaDashboardScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  QaDashboardScreenDto({required this.id, required this.raw});

  factory QaDashboardScreenDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

