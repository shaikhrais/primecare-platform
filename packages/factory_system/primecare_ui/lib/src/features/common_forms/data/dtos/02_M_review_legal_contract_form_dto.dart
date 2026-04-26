// Layer: 02_MODELS_FOUNDATION
class ReviewLegalContractFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ReviewLegalContractFormDto({required this.id, required this.raw});

  factory ReviewLegalContractFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewLegalContractFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
