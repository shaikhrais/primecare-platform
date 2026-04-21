// Layer: 02_MODELS_FOUNDATION
class FranchiseRefundsDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseRefundsDashboardViewModelDto({required this.id, required this.raw});

  factory FranchiseRefundsDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return FranchiseRefundsDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

