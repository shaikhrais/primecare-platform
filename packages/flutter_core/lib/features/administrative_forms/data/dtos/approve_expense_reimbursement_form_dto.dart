class ApproveExpenseReimbursementFormDto {
  final String? id;
  final String? employeeName;
  final num? requestedAmount;
  final String? expenseCategory;
  final String? description;
  final String? status;

  ApproveExpenseReimbursementFormDto({
    this.id,
    this.employeeName,
    this.requestedAmount,
    this.expenseCategory,
    this.description,
    this.status,
  });

  factory ApproveExpenseReimbursementFormDto.fromJson(Map<String, dynamic> json) {
    return ApproveExpenseReimbursementFormDto(
      id: json['id'] as String?,
      employeeName: json['employeeName'] as String?,
      requestedAmount: json['requestedAmount'] as num?,
      expenseCategory: json['expenseCategory'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeName': employeeName,
      'requestedAmount': requestedAmount,
      'expenseCategory': expenseCategory,
      'description': description,
      'status': status,
    };
  }
}
