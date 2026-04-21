// Layer: 02_MODELS_FOUNDATION
class QaDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  QaDashboardMapperDto({required this.id, required this.raw});

  factory QaDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

