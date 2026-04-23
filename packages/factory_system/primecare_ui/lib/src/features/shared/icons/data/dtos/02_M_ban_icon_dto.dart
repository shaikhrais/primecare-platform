// Layer: 02_MODELS_FOUNDATION
class BanIconDto {
  final String id;
  final Map<String, dynamic> raw;

  BanIconDto({required this.id, required this.raw});

  factory BanIconDto.fromJson(Map<String, dynamic> json) {
    return BanIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

