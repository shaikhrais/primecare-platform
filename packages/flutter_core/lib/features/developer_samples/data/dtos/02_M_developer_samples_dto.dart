// Layer: 02_MODELS_FOUNDATION
class DeveloperSamplesDTO {
  final String apiTitle;
  final String apiStatus;

  const DeveloperSamplesDTO({required this.apiTitle, required this.apiStatus});

  factory DeveloperSamplesDTO.fromJson(Map<String, dynamic> json) {
    return DeveloperSamplesDTO(
      apiTitle: json['title'] as String? ?? 'Default Title',
      apiStatus: json['status'] as String? ?? 'ACTIVE',
    );
  }
}
