class BillingSummaryViewModel {
  final String accountId;
  final double totalDue;
  final double amountPaid;
  final String nextDueDate;
  final bool isOverdue;

  BillingSummaryViewModel({
    required this.accountId,
    required this.totalDue,
    required this.amountPaid,
    required this.nextDueDate,
    required this.isOverdue,
  });
}

class BillingSummaryDto {
  final String id;
  final num balance;
  final num paid;
  final String deadline;
  final bool pastDue;

  BillingSummaryDto({
    required this.id,
    required this.balance,
    required this.paid,
    required this.deadline,
    required this.pastDue,
  });

  factory BillingSummaryDto.fromJson(Map<String, dynamic> json) {
    return BillingSummaryDto(
      id: json['accountId'] ?? json['id'] ?? '',
      balance: json['balance'] ?? 0,
      paid: json['paid'] ?? 0,
      deadline: json['deadline'] ?? '',
      pastDue: json['pastDue'] ?? false,
    );
  }
}
