// Layer: 02_MODELS_FOUNDATION
class FranchiseSalesManagerDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseSalesManagerDashboardMapperDto({required this.id, required this.raw});

  factory FranchiseSalesManagerDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return FranchiseSalesManagerDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

