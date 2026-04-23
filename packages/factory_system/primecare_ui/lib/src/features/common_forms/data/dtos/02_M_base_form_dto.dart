// Layer: 02_MODELS_FOUNDATION
class BaseFormDto {
  final String id;
  final Map<String, dynamic> raw;

  BaseFormDto({required this.id, required this.raw});

  factory BaseFormDto.fromJson(Map<String, dynamic> json) {
    return BaseFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

