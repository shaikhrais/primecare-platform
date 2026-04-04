class VisitDetailsViewModel {
  final String visitId;
  final String providerName;
  final String date;
  final String time;
  final String summary;
  final bool isCompleted;

  VisitDetailsViewModel({
    required this.visitId,
    required this.providerName,
    required this.date,
    required this.time,
    required this.summary,
    required this.isCompleted,
  });
}

class VisitDetailsDto {
  final String id;
  final String doctorName;
  final String scheduledDate;
  final String scheduledTime;
  final String notes;
  final bool statusCompleted;

  VisitDetailsDto({
    required this.id,
    required this.doctorName,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.notes,
    required this.statusCompleted,
  });

  factory VisitDetailsDto.fromJson(Map<String, dynamic> json) {
    return VisitDetailsDto(
      id: json['id']?.toString() ?? '',
      doctorName: json['doctorName'] ?? '',
      scheduledDate: json['scheduledDate'] ?? '',
      scheduledTime: json['scheduledTime'] ?? '',
      notes: json['notes'] ?? '',
      statusCompleted: json['statusCompleted'] ?? false,
    );
  }
}
