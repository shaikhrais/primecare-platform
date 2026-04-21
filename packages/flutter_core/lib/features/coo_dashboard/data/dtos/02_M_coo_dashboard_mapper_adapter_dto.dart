// Layer: 02_MODELS_FOUNDATION
class CooDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CooDashboardMapperAdapterDto({required this.id, required this.raw});

  factory CooDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
