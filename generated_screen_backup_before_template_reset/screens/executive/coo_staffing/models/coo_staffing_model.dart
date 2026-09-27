class CooStaffingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CooStaffingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CooStaffingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CooStaffingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
