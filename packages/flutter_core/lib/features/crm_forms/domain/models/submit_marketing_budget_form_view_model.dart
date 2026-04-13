class SubmitMarketingBudgetFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;
  final String budgetId;
  final String campaignName;
  final double totalBudget;
  final DateTime? startDate;
  final DateTime? endDate;
  final String platform;
  final String details;

  SubmitMarketingBudgetFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
    this.budgetId = '',
    this.campaignName = '',
    this.totalBudget = 0.0,
    this.startDate,
    this.endDate,
    this.platform = '',
    this.details = '',
  });

  SubmitMarketingBudgetFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
    String? budgetId,
    String? campaignName,
    double? totalBudget,
    DateTime? startDate,
    DateTime? endDate,
    String? platform,
    String? details,
  }) {
    return SubmitMarketingBudgetFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
      budgetId: budgetId ?? this.budgetId,
      campaignName: campaignName ?? this.campaignName,
      totalBudget: totalBudget ?? this.totalBudget,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      platform: platform ?? this.platform,
      details: details ?? this.details,
    );
  }
}
