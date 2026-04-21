// Layer: 02_MODELS_FOUNDATION
class CfoDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CfoDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory CfoDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
