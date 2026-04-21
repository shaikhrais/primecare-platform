// Layer: 02_MODELS_FOUNDATION
class Layout1Dto {
  final String id;
  final Map<String, dynamic> raw;

  Layout1Dto({required this.id, required this.raw});

  factory Layout1Dto.fromJson(Map<String, dynamic> json) {
    return Layout1Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

