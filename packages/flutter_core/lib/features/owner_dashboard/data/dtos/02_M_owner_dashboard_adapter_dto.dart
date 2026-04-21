// Layer: 02_MODELS_FOUNDATION
class OwnerDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  OwnerDashboardAdapterDto({required this.id, required this.raw});

  factory OwnerDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return OwnerDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
