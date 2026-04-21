// Layer: 02_MODELS_FOUNDATION
class FuseNavHorizontalGroupDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavHorizontalGroupDto({required this.id, required this.raw});

  factory FuseNavHorizontalGroupDto.fromJson(Map<String, dynamic> json) {
    return FuseNavHorizontalGroupDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

