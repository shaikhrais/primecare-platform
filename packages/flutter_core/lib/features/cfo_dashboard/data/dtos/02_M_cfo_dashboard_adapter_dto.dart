// Layer: 02_MODELS_FOUNDATION
class CfoDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CfoDashboardAdapterDto({required this.id, required this.raw});

  factory CfoDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
