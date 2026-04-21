// Layer: 02_MODELS_FOUNDATION
class GuestDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  GuestDashboardAdapterDto({required this.id, required this.raw});

  factory GuestDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return GuestDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
