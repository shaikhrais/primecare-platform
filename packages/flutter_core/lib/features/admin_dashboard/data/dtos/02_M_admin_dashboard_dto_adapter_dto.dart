// Layer: 02_MODELS_FOUNDATION
class AdminDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminDashboardDtoAdapterDto({required this.id, required this.raw});

  factory AdminDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return AdminDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
