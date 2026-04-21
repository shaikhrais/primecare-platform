// Layer: 02_MODELS_FOUNDATION
class OperationsManagerDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  OperationsManagerDashboardAdapterDto({required this.id, required this.raw});

  factory OperationsManagerDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return OperationsManagerDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
