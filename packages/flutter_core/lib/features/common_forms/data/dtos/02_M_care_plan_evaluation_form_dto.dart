// Layer: 02_MODELS_FOUNDATION
class CarePlanEvaluationFormDto {
  final String id;
  final Map<String, dynamic> raw;

  CarePlanEvaluationFormDto({required this.id, required this.raw});

  factory CarePlanEvaluationFormDto.fromJson(Map<String, dynamic> json) {
    return CarePlanEvaluationFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

