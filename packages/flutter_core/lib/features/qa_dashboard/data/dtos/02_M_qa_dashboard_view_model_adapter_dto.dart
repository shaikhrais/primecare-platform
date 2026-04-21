// Layer: 02_MODELS_FOUNDATION
class QaDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  QaDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory QaDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
