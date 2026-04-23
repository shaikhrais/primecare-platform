// Layer: 02_MODELS_FOUNDATION
class UseFuseDialogContextDto {
  final String id;
  final Map<String, dynamic> raw;

  UseFuseDialogContextDto({required this.id, required this.raw});

  factory UseFuseDialogContextDto.fromJson(Map<String, dynamic> json) {
    return UseFuseDialogContextDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

