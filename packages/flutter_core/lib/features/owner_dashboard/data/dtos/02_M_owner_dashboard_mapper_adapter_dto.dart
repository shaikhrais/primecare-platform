// Layer: 02_MODELS_FOUNDATION
class OwnerDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  OwnerDashboardMapperAdapterDto({required this.id, required this.raw});

  factory OwnerDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return OwnerDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
