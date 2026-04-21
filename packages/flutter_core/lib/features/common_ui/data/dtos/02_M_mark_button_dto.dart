// Layer: 02_MODELS_FOUNDATION
class MarkButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  MarkButtonDto({required this.id, required this.raw});

  factory MarkButtonDto.fromJson(Map<String, dynamic> json) {
    return MarkButtonDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

