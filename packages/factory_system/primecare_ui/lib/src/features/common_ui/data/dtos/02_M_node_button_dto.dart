// Layer: 02_MODELS_FOUNDATION
class NodeButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  NodeButtonDto({required this.id, required this.raw});

  factory NodeButtonDto.fromJson(Map<String, dynamic> json) {
    return NodeButtonDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
