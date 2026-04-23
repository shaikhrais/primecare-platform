// Layer: 02_MODELS_FOUNDATION
class ApproveRealEstateFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ApproveRealEstateFormDto({required this.id, required this.raw});

  factory ApproveRealEstateFormDto.fromJson(Map<String, dynamic> json) {
    return ApproveRealEstateFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

