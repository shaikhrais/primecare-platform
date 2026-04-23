// Layer: 02_MODELS_FOUNDATION
class ListIconDto {
  final String id;
  final Map<String, dynamic> raw;

  ListIconDto({required this.id, required this.raw});

  factory ListIconDto.fromJson(Map<String, dynamic> json) {
    return ListIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

