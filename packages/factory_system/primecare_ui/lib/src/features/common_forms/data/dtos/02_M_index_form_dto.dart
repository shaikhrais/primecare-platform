// Layer: 02_MODELS_FOUNDATION
class IndexFormDto {
  final String id;
  final Map<String, dynamic> raw;

  IndexFormDto({required this.id, required this.raw});

  factory IndexFormDto.fromJson(Map<String, dynamic> json) {
    return IndexFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

