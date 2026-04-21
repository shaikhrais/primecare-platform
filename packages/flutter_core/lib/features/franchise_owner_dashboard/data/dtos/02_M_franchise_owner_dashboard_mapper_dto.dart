// Layer: 02_MODELS_FOUNDATION
class FranchiseOwnerDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseOwnerDashboardMapperDto({required this.id, required this.raw});

  factory FranchiseOwnerDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return FranchiseOwnerDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

