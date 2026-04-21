// Layer: 02_MODELS_FOUNDATION
class FranchiseDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseDashboardDtoDto({required this.id, required this.raw});

  factory FranchiseDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return FranchiseDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

