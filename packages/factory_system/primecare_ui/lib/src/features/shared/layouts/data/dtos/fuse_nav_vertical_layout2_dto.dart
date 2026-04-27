// Layer: 02_MODELS_FOUNDATION
class FuseNavVerticalLayout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavVerticalLayout2Dto({required this.id, required this.raw});

  factory FuseNavVerticalLayout2Dto.fromJson(Map<String, dynamic> json) {
    return FuseNavVerticalLayout2Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
