// Layer: 02_MODELS_FOUNDATION
class ReviewMedicationInventoryFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ReviewMedicationInventoryFormDto({required this.id, required this.raw});

  factory ReviewMedicationInventoryFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewMedicationInventoryFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
