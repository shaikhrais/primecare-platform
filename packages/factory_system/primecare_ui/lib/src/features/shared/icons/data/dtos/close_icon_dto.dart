// Layer: 02_MODELS_FOUNDATION
class CloseIconDto {
  final String id;
  final Map<String, dynamic> raw;

  CloseIconDto({required this.id, required this.raw});

  factory CloseIconDto.fromJson(Map<String, dynamic> json) {
    return CloseIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
