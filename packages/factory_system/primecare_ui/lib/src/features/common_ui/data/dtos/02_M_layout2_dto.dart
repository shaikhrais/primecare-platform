// Layer: 02_MODELS_FOUNDATION
class Layout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  Layout2Dto({required this.id, required this.raw});

  factory Layout2Dto.fromJson(Map<String, dynamic> json) {
    return Layout2Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

