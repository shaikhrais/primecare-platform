// Layer: 02_MODELS_FOUNDATION
class FamilyDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FamilyDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory FamilyDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return FamilyDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
