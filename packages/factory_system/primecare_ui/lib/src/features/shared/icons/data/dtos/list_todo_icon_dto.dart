// Layer: 02_MODELS_FOUNDATION
class ListTodoIconDto {
  final String id;
  final Map<String, dynamic> raw;

  ListTodoIconDto({required this.id, required this.raw});

  factory ListTodoIconDto.fromJson(Map<String, dynamic> json) {
    return ListTodoIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
