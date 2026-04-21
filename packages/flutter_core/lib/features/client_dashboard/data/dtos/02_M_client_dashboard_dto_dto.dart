// Layer: 02_MODELS_FOUNDATION
class ClientDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  ClientDashboardDtoDto({required this.id, required this.raw});

  factory ClientDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return ClientDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

