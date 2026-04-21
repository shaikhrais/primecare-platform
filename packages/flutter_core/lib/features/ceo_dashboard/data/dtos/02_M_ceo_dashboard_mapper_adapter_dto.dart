// Layer: 02_MODELS_FOUNDATION
class CeoDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CeoDashboardMapperAdapterDto({required this.id, required this.raw});

  factory CeoDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
