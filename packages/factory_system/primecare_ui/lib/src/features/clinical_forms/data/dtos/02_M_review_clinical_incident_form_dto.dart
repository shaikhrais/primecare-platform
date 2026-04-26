// Layer: 02_MODELS_FOUNDATION
class ReviewClinicalIncidentFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ReviewClinicalIncidentFormDto({required this.id, required this.raw});

  factory ReviewClinicalIncidentFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewClinicalIncidentFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
