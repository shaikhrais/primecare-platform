// Layer: 02_MODELS_FOUNDATION
class FranchiseDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory FranchiseDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
