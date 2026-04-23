// Layer: 02_MODELS_FOUNDATION
class ReviewCarePlanFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ReviewCarePlanFormDto({required this.id, required this.raw});

  factory ReviewCarePlanFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewCarePlanFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

