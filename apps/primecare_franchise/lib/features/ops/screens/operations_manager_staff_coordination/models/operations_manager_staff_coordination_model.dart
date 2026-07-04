class OperationsManagerStaffCoordinationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OperationsManagerStaffCoordinationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OperationsManagerStaffCoordinationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OperationsManagerStaffCoordinationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
