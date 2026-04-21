// Layer: 02_MODELS_FOUNDATION
class Layout3Dto {
  final String id;
  final Map<String, dynamic> raw;

  Layout3Dto({required this.id, required this.raw});

  factory Layout3Dto.fromJson(Map<String, dynamic> json) {
    return Layout3Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

