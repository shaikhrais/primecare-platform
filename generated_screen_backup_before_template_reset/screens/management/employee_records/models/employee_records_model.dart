class EmployeeRecordsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const EmployeeRecordsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  EmployeeRecordsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return EmployeeRecordsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
