// Layer: 02_MODELS_FOUNDATION
class GuestDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  GuestDashboardMapperAdapterDto({required this.id, required this.raw});

  factory GuestDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return GuestDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
