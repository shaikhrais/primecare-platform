class HomeCarePlanModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HomeCarePlanModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HomeCarePlanModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HomeCarePlanModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
