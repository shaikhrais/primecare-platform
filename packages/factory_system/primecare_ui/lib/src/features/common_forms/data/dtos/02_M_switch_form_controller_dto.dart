// Layer: 02_MODELS_FOUNDATION
class SwitchFormControllerDto {
  final String id;
  final Map<String, dynamic> raw;

  SwitchFormControllerDto({required this.id, required this.raw});

  factory SwitchFormControllerDto.fromJson(Map<String, dynamic> json) {
    return SwitchFormControllerDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
