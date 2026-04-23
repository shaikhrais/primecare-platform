// Layer: 02_MODELS_FOUNDATION
class PurchaseButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  PurchaseButtonDto({required this.id, required this.raw});

  factory PurchaseButtonDto.fromJson(Map<String, dynamic> json) {
    return PurchaseButtonDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

