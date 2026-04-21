// Layer: 02_MODELS_FOUNDATION
class SubscriptionUpgradeScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  SubscriptionUpgradeScreenDto({required this.id, required this.raw});

  factory SubscriptionUpgradeScreenDto.fromJson(Map<String, dynamic> json) {
    return SubscriptionUpgradeScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

