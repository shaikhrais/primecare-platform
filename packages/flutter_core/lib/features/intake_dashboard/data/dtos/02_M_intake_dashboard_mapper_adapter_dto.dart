// Layer: 02_MODELS_FOUNDATION
class IntakeDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  IntakeDashboardMapperAdapterDto({required this.id, required this.raw});

  factory IntakeDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return IntakeDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
