// Layer: 02_MODELS_FOUNDATION
class DynamicRoleDashboardScreenAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  DynamicRoleDashboardScreenAdapterDto({required this.id, required this.raw});

  factory DynamicRoleDashboardScreenAdapterDto.fromJson(Map<String, dynamic> json) {
    return DynamicRoleDashboardScreenAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
