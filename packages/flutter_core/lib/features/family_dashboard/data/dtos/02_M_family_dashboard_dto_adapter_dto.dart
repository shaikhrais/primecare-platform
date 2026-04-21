// Layer: 02_MODELS_FOUNDATION
class FamilyDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FamilyDashboardDtoAdapterDto({required this.id, required this.raw});

  factory FamilyDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return FamilyDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
