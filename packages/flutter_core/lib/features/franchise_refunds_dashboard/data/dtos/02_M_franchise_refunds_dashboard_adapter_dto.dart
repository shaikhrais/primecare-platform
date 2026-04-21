// Layer: 02_MODELS_FOUNDATION
class FranchiseRefundsDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseRefundsDashboardAdapterDto({required this.id, required this.raw});

  factory FranchiseRefundsDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseRefundsDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
