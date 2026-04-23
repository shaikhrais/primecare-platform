// Layer: 02_MODELS_FOUNDATION
class LinkIconDto {
  final String id;
  final Map<String, dynamic> raw;

  LinkIconDto({required this.id, required this.raw});

  factory LinkIconDto.fromJson(Map<String, dynamic> json) {
    return LinkIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

