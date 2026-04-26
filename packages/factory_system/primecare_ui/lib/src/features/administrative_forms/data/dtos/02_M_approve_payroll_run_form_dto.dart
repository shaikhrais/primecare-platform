// Layer: 02_MODELS_FOUNDATION
class ApprovePayrollRunFormDto {
  final String? id;
  final String? periodStartDate;
  final String? periodEndDate;
  final num? totalPayrollAmount;
  final int? totalEmployees;
  final String? status;

  ApprovePayrollRunFormDto({
    this.id,
    this.periodStartDate,
    this.periodEndDate,
    this.totalPayrollAmount,
    this.totalEmployees,
    this.status,
  });

  factory ApprovePayrollRunFormDto.fromJson(Map<String, dynamic> json) {
    return ApprovePayrollRunFormDto(
      id: json['id'] as String?,
      periodStartDate: json['periodStartDate'] as String?,
      periodEndDate: json['periodEndDate'] as String?,
      totalPayrollAmount: json['totalPayrollAmount'] as num?,
      totalEmployees: json['totalEmployees'] as int?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'periodStartDate': periodStartDate,
      'periodEndDate': periodEndDate,
      'totalPayrollAmount': totalPayrollAmount,
      'totalEmployees': totalEmployees,
      'status': status,
    };
  }
}
