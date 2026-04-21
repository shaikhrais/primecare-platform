// Layer: 02_MODELS_FOUNDATION
class QaDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  QaDashboardDtoDto({required this.id, required this.raw});

  factory QaDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

