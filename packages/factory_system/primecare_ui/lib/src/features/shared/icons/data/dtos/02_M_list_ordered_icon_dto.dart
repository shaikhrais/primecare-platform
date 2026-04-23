// Layer: 02_MODELS_FOUNDATION
class ListOrderedIconDto {
  final String id;
  final Map<String, dynamic> raw;

  ListOrderedIconDto({required this.id, required this.raw});

  factory ListOrderedIconDto.fromJson(Map<String, dynamic> json) {
    return ListOrderedIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

