// Layer: 02_MODELS_FOUNDATION
class HeadOfBusDevDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfBusDevDashboardAdapterDto({required this.id, required this.raw});

  factory HeadOfBusDevDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return HeadOfBusDevDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
