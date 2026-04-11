class CfoDashboardDto {
  final double ebitda;
  final double cashFlow;
  final double operatingMargin;
  final double accountsReceivable;
  
  final List<double>? revenueData;
  final List<String>? revenueLabels;
  final List<double>? expenseData;
  final List<String>? expenseLabels;
  final double? ebitdaTargetMax;

  CfoDashboardDto({
    required this.ebitda,
    required this.cashFlow,
    required this.operatingMargin,
    required this.accountsReceivable,
    this.revenueData,
    this.revenueLabels,
    this.expenseData,
    this.expenseLabels,
    this.ebitdaTargetMax,
  });

  factory CfoDashboardDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardDto(
      ebitda: (json['ebitda'] ?? 0).toDouble(),
      cashFlow: (json['cashFlow'] ?? 0).toDouble(),
      operatingMargin: (json['operatingMargin'] ?? 0).toDouble(),
      accountsReceivable: (json['accountsReceivable'] ?? 0).toDouble(),
      revenueData: (json['revenueData'] as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList(),
      revenueLabels: (json['revenueLabels'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      expenseData: (json['expenseData'] as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList(),
      expenseLabels: (json['expenseLabels'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      ebitdaTargetMax: (json['ebitdaTargetMax'] as num?)?.toDouble(),
    );
  }
}
