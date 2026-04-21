// Layer: 02_MODELS_FOUNDATION
class AdminDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminDashboardMapperAdapterDto({required this.id, required this.raw});

  factory AdminDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return AdminDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
