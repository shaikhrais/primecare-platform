// Layer: 02_MODELS_FOUNDATION
class RadioFormControllerDto {
  final String id;
  final Map<String, dynamic> raw;

  RadioFormControllerDto({required this.id, required this.raw});

  factory RadioFormControllerDto.fromJson(Map<String, dynamic> json) {
    return RadioFormControllerDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
