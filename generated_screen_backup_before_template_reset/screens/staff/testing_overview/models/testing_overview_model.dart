class TestingOverviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TestingOverviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TestingOverviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TestingOverviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
