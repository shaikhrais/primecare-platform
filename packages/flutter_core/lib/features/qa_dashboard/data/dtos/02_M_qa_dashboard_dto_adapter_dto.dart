// Layer: 02_MODELS_FOUNDATION
class QaDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  QaDashboardDtoAdapterDto({required this.id, required this.raw});

  factory QaDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
