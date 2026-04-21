// Layer: 02_MODELS_FOUNDATION
class QaDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  QaDashboardViewModelDto({required this.id, required this.raw});

  factory QaDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

