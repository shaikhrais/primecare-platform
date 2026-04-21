// Layer: 02_MODELS_FOUNDATION
class PageTitleDto {
  final String id;
  final Map<String, dynamic> raw;

  PageTitleDto({required this.id, required this.raw});

  factory PageTitleDto.fromJson(Map<String, dynamic> json) {
    return PageTitleDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

