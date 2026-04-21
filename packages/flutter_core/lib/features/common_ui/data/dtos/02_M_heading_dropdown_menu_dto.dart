// Layer: 02_MODELS_FOUNDATION
class HeadingDropdownMenuDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadingDropdownMenuDto({required this.id, required this.raw});

  factory HeadingDropdownMenuDto.fromJson(Map<String, dynamic> json) {
    return HeadingDropdownMenuDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

