// Layer: 02_MODELS_FOUNDATION
class GuestDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  GuestDashboardDtoAdapterDto({required this.id, required this.raw});

  factory GuestDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return GuestDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
