class RnCarePlanData {
  final String id;
  final String patientName;
  final List<String> diagnoses;
  final List<String> clinicalGoals;
  final String status;

  RnCarePlanData({
    required this.id,
    required this.patientName,
    required this.diagnoses,
    required this.clinicalGoals,
    required this.status,
  });

  factory RnCarePlanData.fromJson(Map<String, dynamic> json) {
    final clientMap = json['client'] as Map<String, dynamic>?;

    return RnCarePlanData(
      id: json['id'] as String? ?? '',
      patientName: clientMap?['fullName'] as String? ?? 'Unknown Patient',
      diagnoses:
          (json['diagnoses'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      clinicalGoals:
          (json['clinicalGoals'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      status: json['status'] as String? ?? 'active',
    );
  }
}
