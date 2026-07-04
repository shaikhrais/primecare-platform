class FamilyMemberProfileModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FamilyMemberProfileModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FamilyMemberProfileModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FamilyMemberProfileModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
