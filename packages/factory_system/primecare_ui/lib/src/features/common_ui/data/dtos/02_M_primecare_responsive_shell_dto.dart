// Layer: 02_MODELS_FOUNDATION
class PrimecareResponsiveShellDto {
  final String id;
  final Map<String, dynamic> raw;

  PrimecareResponsiveShellDto({required this.id, required this.raw});

  factory PrimecareResponsiveShellDto.fromJson(Map<String, dynamic> json) {
    return PrimecareResponsiveShellDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

