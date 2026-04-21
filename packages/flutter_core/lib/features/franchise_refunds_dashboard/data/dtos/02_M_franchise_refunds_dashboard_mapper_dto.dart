// Layer: 02_MODELS_FOUNDATION
class FranchiseRefundsDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseRefundsDashboardMapperDto({required this.id, required this.raw});

  factory FranchiseRefundsDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return FranchiseRefundsDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

