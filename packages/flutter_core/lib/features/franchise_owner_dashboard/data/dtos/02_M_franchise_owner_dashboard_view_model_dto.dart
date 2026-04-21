// Layer: 02_MODELS_FOUNDATION
class FranchiseOwnerDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseOwnerDashboardViewModelDto({required this.id, required this.raw});

  factory FranchiseOwnerDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return FranchiseOwnerDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

