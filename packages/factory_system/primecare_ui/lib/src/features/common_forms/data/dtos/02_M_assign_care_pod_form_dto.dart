// Layer: 02_MODELS_FOUNDATION
class AssignCarePodFormDto {
  final String id;
  final Map<String, dynamic> raw;

  AssignCarePodFormDto({required this.id, required this.raw});

  factory AssignCarePodFormDto.fromJson(Map<String, dynamic> json) {
    return AssignCarePodFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
