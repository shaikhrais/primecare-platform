// Layer: 02_MODELS_FOUNDATION
class CeoDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CeoDashboardAdapterDto({required this.id, required this.raw});

  factory CeoDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
