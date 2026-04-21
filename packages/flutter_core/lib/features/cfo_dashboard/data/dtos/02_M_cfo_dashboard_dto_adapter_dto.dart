// Layer: 02_MODELS_FOUNDATION
class CfoDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CfoDashboardDtoAdapterDto({required this.id, required this.raw});

  factory CfoDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
