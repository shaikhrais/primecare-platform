// Layer: 02_MODELS_FOUNDATION
class FooterLayout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  FooterLayout2Dto({required this.id, required this.raw});

  factory FooterLayout2Dto.fromJson(Map<String, dynamic> json) {
    return FooterLayout2Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

