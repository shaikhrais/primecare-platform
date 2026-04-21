// Layer: 02_MODELS_FOUNDATION
class FranchiseDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseDashboardMapperDto({required this.id, required this.raw});

  factory FranchiseDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return FranchiseDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

