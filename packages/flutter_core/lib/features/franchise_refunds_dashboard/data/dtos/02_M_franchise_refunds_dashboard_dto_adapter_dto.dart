// Layer: 02_MODELS_FOUNDATION
class FranchiseRefundsDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseRefundsDashboardDtoAdapterDto({required this.id, required this.raw});

  factory FranchiseRefundsDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseRefundsDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
