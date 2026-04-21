// Layer: 02_MODELS_FOUNDATION
class AdminDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminDashboardAdapterDto({required this.id, required this.raw});

  factory AdminDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return AdminDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
