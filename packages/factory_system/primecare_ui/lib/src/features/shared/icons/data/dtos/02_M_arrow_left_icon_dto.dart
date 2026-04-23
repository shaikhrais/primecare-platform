// Layer: 02_MODELS_FOUNDATION
class ArrowLeftIconDto {
  final String id;
  final Map<String, dynamic> raw;

  ArrowLeftIconDto({required this.id, required this.raw});

  factory ArrowLeftIconDto.fromJson(Map<String, dynamic> json) {
    return ArrowLeftIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

