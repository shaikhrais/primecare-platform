// Layer: 02_MODELS_FOUNDATION
class CtoDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CtoDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory CtoDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return CtoDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
