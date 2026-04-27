// Layer: 02_MODELS_FOUNDATION
class ListDropdownMenuDto {
  final String id;
  final Map<String, dynamic> raw;

  ListDropdownMenuDto({required this.id, required this.raw});

  factory ListDropdownMenuDto.fromJson(Map<String, dynamic> json) {
    return ListDropdownMenuDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
