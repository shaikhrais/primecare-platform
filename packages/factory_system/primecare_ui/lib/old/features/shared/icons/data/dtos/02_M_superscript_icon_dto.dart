// Layer: 02_MODELS_FOUNDATION
class SuperscriptIconDto {
  final String id;
  final Map<String, dynamic> raw;

  SuperscriptIconDto({required this.id, required this.raw});

  factory SuperscriptIconDto.fromJson(Map<String, dynamic> json) {
    return SuperscriptIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
