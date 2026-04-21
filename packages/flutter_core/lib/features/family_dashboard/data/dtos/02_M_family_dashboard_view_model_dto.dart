// Layer: 02_MODELS_FOUNDATION
class FamilyDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  FamilyDashboardViewModelDto({required this.id, required this.raw});

  factory FamilyDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return FamilyDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

