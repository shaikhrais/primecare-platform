// Layer: 02_MODELS_FOUNDATION
class NewEmployeeOnboardingFormDto {
  final Map<String, dynamic> rawData;

  NewEmployeeOnboardingFormDto({required this.rawData});

  factory NewEmployeeOnboardingFormDto.fromJson(Map<String, dynamic> json) {
    return NewEmployeeOnboardingFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
