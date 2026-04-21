// Layer: 02_MODELS_FOUNDATION
class LeftSideLayout1Dto {
  final String id;
  final Map<String, dynamic> raw;

  LeftSideLayout1Dto({required this.id, required this.raw});

  factory LeftSideLayout1Dto.fromJson(Map<String, dynamic> json) {
    return LeftSideLayout1Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

