// Layer: 02_MODELS_FOUNDATION
class HeadOfBusDevDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfBusDevDashboardMapperAdapterDto({required this.id, required this.raw});

  factory HeadOfBusDevDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return HeadOfBusDevDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
