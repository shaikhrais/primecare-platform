// Layer: 02_MODELS_FOUNDATION
class FranchiseOnboardingChecklistFormDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseOnboardingChecklistFormDto({required this.id, required this.raw});

  factory FranchiseOnboardingChecklistFormDto.fromJson(Map<String, dynamic> json) {
    return FranchiseOnboardingChecklistFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

