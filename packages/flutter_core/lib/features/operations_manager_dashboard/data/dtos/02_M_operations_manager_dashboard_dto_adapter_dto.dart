// Layer: 02_MODELS_FOUNDATION
class OperationsManagerDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  OperationsManagerDashboardDtoAdapterDto({required this.id, required this.raw});

  factory OperationsManagerDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return OperationsManagerDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
