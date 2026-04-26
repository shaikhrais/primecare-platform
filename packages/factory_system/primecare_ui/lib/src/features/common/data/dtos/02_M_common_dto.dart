// Layer: 02_MODELS_FOUNDATION
class CommonDTO {
  final String apiTitle;
  final String apiStatus;

  const CommonDTO({required this.apiTitle, required this.apiStatus});

  factory CommonDTO.fromJson(Map<String, dynamic> json) {
    return CommonDTO(
      apiTitle: json['title'] as String? ?? 'Default Title',
      apiStatus: json['status'] as String? ?? 'ACTIVE',
    );
  }
}
