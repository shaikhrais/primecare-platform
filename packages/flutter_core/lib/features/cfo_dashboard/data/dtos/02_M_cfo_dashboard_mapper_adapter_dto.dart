// Layer: 02_MODELS_FOUNDATION
class CfoDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CfoDashboardMapperAdapterDto({required this.id, required this.raw});

  factory CfoDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
