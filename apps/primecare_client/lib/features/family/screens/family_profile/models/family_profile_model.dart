class FamilyProfileModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FamilyProfileModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FamilyProfileModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FamilyProfileModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
