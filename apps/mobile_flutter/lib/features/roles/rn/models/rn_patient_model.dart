class RnPatientData {
  final String id;
  final String name;
  final int acuityLevel;

  RnPatientData({
    required this.id,
    required this.name,
    required this.acuityLevel,
  });

  factory RnPatientData.fromJson(Map<String, dynamic> json) {
    return RnPatientData(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown Patient',
      acuityLevel: json['acuityLevel'] as int? ?? 1,
    );
  }
}
