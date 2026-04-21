// Layer: 02_MODELS_FOUNDATION
class FranchiseSalesManagerDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseSalesManagerDashboardDtoDto({required this.id, required this.raw});

  factory FranchiseSalesManagerDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return FranchiseSalesManagerDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

