// Layer: 02_MODELS_FOUNDATION
class AuditRoyaltyPaymentFormDto {
  final String id;
  final Map<String, dynamic> raw;

  AuditRoyaltyPaymentFormDto({required this.id, required this.raw});

  factory AuditRoyaltyPaymentFormDto.fromJson(Map<String, dynamic> json) {
    return AuditRoyaltyPaymentFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
