// Layer: 02_MODELS_FOUNDATION
class AlignLeftIconDto {
  final String id;
  final Map<String, dynamic> raw;

  AlignLeftIconDto({required this.id, required this.raw});

  factory AlignLeftIconDto.fromJson(Map<String, dynamic> json) {
    return AlignLeftIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

