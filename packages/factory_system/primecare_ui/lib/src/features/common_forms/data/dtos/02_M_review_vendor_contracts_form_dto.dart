// Layer: 02_MODELS_FOUNDATION
class ReviewVendorContractsFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ReviewVendorContractsFormDto({required this.id, required this.raw});

  factory ReviewVendorContractsFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewVendorContractsFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
