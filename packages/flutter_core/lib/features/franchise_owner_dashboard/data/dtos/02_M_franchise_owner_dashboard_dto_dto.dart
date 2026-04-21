// Layer: 02_MODELS_FOUNDATION
class FranchiseOwnerDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseOwnerDashboardDtoDto({required this.id, required this.raw});

  factory FranchiseOwnerDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return FranchiseOwnerDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

