// Layer: 02_MODELS_FOUNDATION
class AlignCenterIconDto {
  final String id;
  final Map<String, dynamic> raw;

  AlignCenterIconDto({required this.id, required this.raw});

  factory AlignCenterIconDto.fromJson(Map<String, dynamic> json) {
    return AlignCenterIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

