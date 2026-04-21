// Layer: 02_MODELS_FOUNDATION
class FuseSettingsViewerDialogDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseSettingsViewerDialogDto({required this.id, required this.raw});

  factory FuseSettingsViewerDialogDto.fromJson(Map<String, dynamic> json) {
    return FuseSettingsViewerDialogDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

