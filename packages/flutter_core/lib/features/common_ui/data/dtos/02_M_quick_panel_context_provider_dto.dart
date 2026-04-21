// Layer: 02_MODELS_FOUNDATION
class QuickPanelContextProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  QuickPanelContextProviderDto({required this.id, required this.raw});

  factory QuickPanelContextProviderDto.fromJson(Map<String, dynamic> json) {
    return QuickPanelContextProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

