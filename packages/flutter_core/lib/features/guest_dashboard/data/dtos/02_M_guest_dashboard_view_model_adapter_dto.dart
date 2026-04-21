// Layer: 02_MODELS_FOUNDATION
class GuestDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  GuestDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory GuestDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return GuestDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
