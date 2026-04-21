// Layer: 02_MODELS_FOUNDATION
class QaDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  QaDashboardAdapterDto({required this.id, required this.raw});

  factory QaDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
