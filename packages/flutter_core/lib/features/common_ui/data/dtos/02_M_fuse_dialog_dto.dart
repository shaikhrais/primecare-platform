// Layer: 02_MODELS_FOUNDATION
class FuseDialogDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseDialogDto({required this.id, required this.raw});

  factory FuseDialogDto.fromJson(Map<String, dynamic> json) {
    return FuseDialogDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

