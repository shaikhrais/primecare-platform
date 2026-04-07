class ClientProfileViewModel {
  final String clientId;
  final String fullName;
  final int age;
  final String status;
  final List<String> recentDiagnoses;

  ClientProfileViewModel({
    required this.clientId,
    required this.fullName,
    required this.age,
    required this.status,
    required this.recentDiagnoses,
  });
}

class ClientProfileDto {
  final String id;
  final String patientName;
  final int age;
  final String currentStatus;
  final List<String>? diagnosesList;

  ClientProfileDto({
    required this.id,
    required this.patientName,
    required this.age,
    required this.currentStatus,
    this.diagnosesList,
  });

  factory ClientProfileDto.fromJson(Map<String, dynamic> json) {
    return ClientProfileDto(
      id: json['id']?.toString() ?? '',
      patientName: json['patientName'] ?? json['full_name'] ?? '',
      age: json['age'] ?? 0,
      currentStatus: json['currentStatus'] ?? 'Unknown',
      diagnosesList: json['diagnosesList'] != null
          ? List<String>.from(json['diagnosesList'])
          : null,
    );
  }
}
