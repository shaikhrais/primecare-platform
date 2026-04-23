// Layer: 02_MODELS_FOUNDATION
class FusePageSimpleHeaderDto {
  final String id;
  final Map<String, dynamic> raw;

  FusePageSimpleHeaderDto({required this.id, required this.raw});

  factory FusePageSimpleHeaderDto.fromJson(Map<String, dynamic> json) {
    return FusePageSimpleHeaderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

