// Layer: 02_MODELS_FOUNDATION
class FuseNavHorizontalLayout1Dto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavHorizontalLayout1Dto({required this.id, required this.raw});

  factory FuseNavHorizontalLayout1Dto.fromJson(Map<String, dynamic> json) {
    return FuseNavHorizontalLayout1Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

