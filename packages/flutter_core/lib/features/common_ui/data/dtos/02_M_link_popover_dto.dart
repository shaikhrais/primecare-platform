// Layer: 02_MODELS_FOUNDATION
class LinkPopoverDto {
  final String id;
  final Map<String, dynamic> raw;

  LinkPopoverDto({required this.id, required this.raw});

  factory LinkPopoverDto.fromJson(Map<String, dynamic> json) {
    return LinkPopoverDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

