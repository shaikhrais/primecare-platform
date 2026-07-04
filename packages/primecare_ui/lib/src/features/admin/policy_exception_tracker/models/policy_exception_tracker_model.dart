class PolicyExceptionTrackerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PolicyExceptionTrackerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PolicyExceptionTrackerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PolicyExceptionTrackerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
