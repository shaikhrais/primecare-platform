class FamilyMemberCareUpdatesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FamilyMemberCareUpdatesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FamilyMemberCareUpdatesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FamilyMemberCareUpdatesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
