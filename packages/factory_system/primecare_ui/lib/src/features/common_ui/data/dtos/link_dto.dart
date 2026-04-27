// Layer: 02_MODELS_FOUNDATION
class LinkDto {
  final String id;
  final Map<String, dynamic> raw;

  LinkDto({required this.id, required this.raw});

  factory LinkDto.fromJson(Map<String, dynamic> json) {
    return LinkDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
