class StaffingOverviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const StaffingOverviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  StaffingOverviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return StaffingOverviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
