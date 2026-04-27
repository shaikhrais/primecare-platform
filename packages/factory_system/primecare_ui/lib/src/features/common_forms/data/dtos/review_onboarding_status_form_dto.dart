// Layer: 02_MODELS_FOUNDATION
class ReviewOnboardingStatusFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ReviewOnboardingStatusFormDto({required this.id, required this.raw});

  factory ReviewOnboardingStatusFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewOnboardingStatusFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
