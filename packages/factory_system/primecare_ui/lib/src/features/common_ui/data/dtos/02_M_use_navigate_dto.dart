// Layer: 02_MODELS_FOUNDATION
class UseNavigateDto {
  final String id;
  final Map<String, dynamic> raw;

  UseNavigateDto({required this.id, required this.raw});

  factory UseNavigateDto.fromJson(Map<String, dynamic> json) {
    return UseNavigateDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

