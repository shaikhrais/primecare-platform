class ApproveLeaveRequestFormDto {
  final String? id;
  final String? employeeName;
  final String? leaveType;
  final String? startDate;
  final String? endDate;
  final String? status;

  ApproveLeaveRequestFormDto({
    this.id,
    this.employeeName,
    this.leaveType,
    this.startDate,
    this.endDate,
    this.status,
  });

  factory ApproveLeaveRequestFormDto.fromJson(Map<String, dynamic> json) {
    return ApproveLeaveRequestFormDto(
      id: json['id'] as String?,
      employeeName: json['employeeName'] as String?,
      leaveType: json['leaveType'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeName': employeeName,
      'leaveType': leaveType,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }
}
