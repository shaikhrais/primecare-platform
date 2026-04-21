// Layer: 02_MODELS_FOUNDATION
class OwnerDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  OwnerDashboardViewModelDto({required this.id, required this.raw});

  factory OwnerDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return OwnerDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

