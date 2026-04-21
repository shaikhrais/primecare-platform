// Layer: 02_MODELS_FOUNDATION
class ProviderLayoutDto {
  final String id;
  final Map<String, dynamic> raw;

  ProviderLayoutDto({required this.id, required this.raw});

  factory ProviderLayoutDto.fromJson(Map<String, dynamic> json) {
    return ProviderLayoutDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

