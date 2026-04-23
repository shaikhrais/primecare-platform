// Layer: 02_MODELS_FOUNDATION
class FuseNavVerticalLayout1Dto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavVerticalLayout1Dto({required this.id, required this.raw});

  factory FuseNavVerticalLayout1Dto.fromJson(Map<String, dynamic> json) {
    return FuseNavVerticalLayout1Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

