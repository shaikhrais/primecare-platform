class ReviewOnboardingStatusFormDto {
  final Map<String, dynamic> rawData;

  ReviewOnboardingStatusFormDto({required this.rawData});

  factory ReviewOnboardingStatusFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewOnboardingStatusFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
