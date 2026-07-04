class StaffProgressModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const StaffProgressModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  StaffProgressModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return StaffProgressModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
