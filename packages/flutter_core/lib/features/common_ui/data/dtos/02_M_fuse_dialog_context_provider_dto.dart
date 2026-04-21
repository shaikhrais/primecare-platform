// Layer: 02_MODELS_FOUNDATION
class FuseDialogContextProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseDialogContextProviderDto({required this.id, required this.raw});

  factory FuseDialogContextProviderDto.fromJson(Map<String, dynamic> json) {
    return FuseDialogContextProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

