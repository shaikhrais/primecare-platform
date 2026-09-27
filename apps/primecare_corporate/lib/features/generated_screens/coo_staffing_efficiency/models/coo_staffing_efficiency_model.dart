class CooStaffingEfficiencyModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CooStaffingEfficiencyModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CooStaffingEfficiencyModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CooStaffingEfficiencyModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
