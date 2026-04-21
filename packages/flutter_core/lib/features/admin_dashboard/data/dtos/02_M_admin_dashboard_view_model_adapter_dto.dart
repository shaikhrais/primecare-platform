// Layer: 02_MODELS_FOUNDATION
class AdminDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory AdminDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return AdminDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
