// Layer: 02_MODELS_FOUNDATION
class QaDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  QaDashboardMapperAdapterDto({required this.id, required this.raw});

  factory QaDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
