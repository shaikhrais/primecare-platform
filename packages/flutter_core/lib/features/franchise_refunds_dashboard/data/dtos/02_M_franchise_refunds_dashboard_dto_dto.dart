// Layer: 02_MODELS_FOUNDATION
class FranchiseRefundsDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseRefundsDashboardDtoDto({required this.id, required this.raw});

  factory FranchiseRefundsDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return FranchiseRefundsDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

