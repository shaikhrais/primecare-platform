// Layer: 02_MODELS_FOUNDATION
class UsePathnameDto {
  final String id;
  final Map<String, dynamic> raw;

  UsePathnameDto({required this.id, required this.raw});

  factory UsePathnameDto.fromJson(Map<String, dynamic> json) {
    return UsePathnameDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

