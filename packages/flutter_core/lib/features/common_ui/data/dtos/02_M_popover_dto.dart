// Layer: 02_MODELS_FOUNDATION
class PopoverDto {
  final String id;
  final Map<String, dynamic> raw;

  PopoverDto({required this.id, required this.raw});

  factory PopoverDto.fromJson(Map<String, dynamic> json) {
    return PopoverDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

