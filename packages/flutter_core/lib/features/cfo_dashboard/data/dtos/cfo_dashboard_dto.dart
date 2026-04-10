class CfoDashboardDto {
  final double ebitda;
  final double cashFlow;
  final double operatingMargin;
  final double accountsReceivable;

  CfoDashboardDto({
    required this.ebitda,
    required this.cashFlow,
    required this.operatingMargin,
    required this.accountsReceivable,
  });

  factory CfoDashboardDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardDto(
      ebitda: (json['ebitda'] ?? 0).toDouble(),
      cashFlow: (json['cashFlow'] ?? 0).toDouble(),
      operatingMargin: (json['operatingMargin'] ?? 0).toDouble(),
      accountsReceivable: (json['accountsReceivable'] ?? 0).toDouble(),
    );
  }
}
