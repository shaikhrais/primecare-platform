// Layer: 02_MODELS_FOUNDATION
class FranchiseReconciliationDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseReconciliationDashboardDtoDto({required this.id, required this.raw});

  factory FranchiseReconciliationDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return FranchiseReconciliationDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

