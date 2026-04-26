// Layer: 02_MODELS_FOUNDATION
class SubmitAdlChecklistFormDto {
  final String id;
  final Map<String, dynamic> raw;

  SubmitAdlChecklistFormDto({required this.id, required this.raw});

  factory SubmitAdlChecklistFormDto.fromJson(Map<String, dynamic> json) {
    return SubmitAdlChecklistFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
