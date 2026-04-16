class FranchiseOnboardingChecklistFormDto {
  final Map<String, dynamic> rawData;

  FranchiseOnboardingChecklistFormDto({required this.rawData});

  factory FranchiseOnboardingChecklistFormDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return FranchiseOnboardingChecklistFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
