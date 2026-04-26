// Layer: 02_MODELS_FOUNDATION
class ListButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  ListButtonDto({required this.id, required this.raw});

  factory ListButtonDto.fromJson(Map<String, dynamic> json) {
    return ListButtonDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
