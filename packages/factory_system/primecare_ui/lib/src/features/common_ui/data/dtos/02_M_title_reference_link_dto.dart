// Layer: 02_MODELS_FOUNDATION
class TitleReferenceLinkDto {
  final String id;
  final Map<String, dynamic> raw;

  TitleReferenceLinkDto({required this.id, required this.raw});

  factory TitleReferenceLinkDto.fromJson(Map<String, dynamic> json) {
    return TitleReferenceLinkDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

