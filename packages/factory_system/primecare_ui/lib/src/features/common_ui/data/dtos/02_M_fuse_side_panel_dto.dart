// Layer: 02_MODELS_FOUNDATION
class FuseSidePanelDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseSidePanelDto({required this.id, required this.raw});

  factory FuseSidePanelDto.fromJson(Map<String, dynamic> json) {
    return FuseSidePanelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

