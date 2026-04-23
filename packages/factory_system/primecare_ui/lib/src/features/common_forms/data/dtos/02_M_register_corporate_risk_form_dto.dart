// Layer: 02_MODELS_FOUNDATION
class RegisterCorporateRiskFormDto {
  final String id;
  final Map<String, dynamic> raw;

  RegisterCorporateRiskFormDto({required this.id, required this.raw});

  factory RegisterCorporateRiskFormDto.fromJson(Map<String, dynamic> json) {
    return RegisterCorporateRiskFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

