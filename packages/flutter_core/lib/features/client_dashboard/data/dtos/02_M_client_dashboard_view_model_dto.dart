// Layer: 02_MODELS_FOUNDATION
class ClientDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  ClientDashboardViewModelDto({required this.id, required this.raw});

  factory ClientDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return ClientDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

