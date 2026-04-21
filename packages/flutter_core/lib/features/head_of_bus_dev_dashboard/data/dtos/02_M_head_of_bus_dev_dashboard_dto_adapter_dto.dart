// Layer: 02_MODELS_FOUNDATION
class HeadOfBusDevDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfBusDevDashboardDtoAdapterDto({required this.id, required this.raw});

  factory HeadOfBusDevDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return HeadOfBusDevDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
