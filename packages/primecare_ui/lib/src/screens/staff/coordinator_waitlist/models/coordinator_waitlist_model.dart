class CoordinatorWaitlistModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CoordinatorWaitlistModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CoordinatorWaitlistModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CoordinatorWaitlistModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
