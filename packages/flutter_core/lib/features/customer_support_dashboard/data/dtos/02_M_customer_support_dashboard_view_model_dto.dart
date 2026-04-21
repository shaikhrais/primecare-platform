// Layer: 02_MODELS_FOUNDATION
class CustomerSupportDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  CustomerSupportDashboardViewModelDto({required this.id, required this.raw});

  factory CustomerSupportDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return CustomerSupportDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

