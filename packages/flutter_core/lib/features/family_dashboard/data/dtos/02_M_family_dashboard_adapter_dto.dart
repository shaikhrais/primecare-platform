// Layer: 02_MODELS_FOUNDATION
class FamilyDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FamilyDashboardAdapterDto({required this.id, required this.raw});

  factory FamilyDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return FamilyDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
