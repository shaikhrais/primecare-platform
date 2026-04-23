// Layer: 02_MODELS_FOUNDATION
class HeadingSixIconDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadingSixIconDto({required this.id, required this.raw});

  factory HeadingSixIconDto.fromJson(Map<String, dynamic> json) {
    return HeadingSixIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

