// Layer: 02_MODELS_FOUNDATION
class FranchiseDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseDashboardViewModelDto({required this.id, required this.raw});

  factory FranchiseDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return FranchiseDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

