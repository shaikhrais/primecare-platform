// Layer: 02_MODELS_FOUNDATION
class SubmitHealthcareClaimFormDto {
  final String id;
  final Map<String, dynamic> raw;

  SubmitHealthcareClaimFormDto({required this.id, required this.raw});

  factory SubmitHealthcareClaimFormDto.fromJson(Map<String, dynamic> json) {
    return SubmitHealthcareClaimFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
