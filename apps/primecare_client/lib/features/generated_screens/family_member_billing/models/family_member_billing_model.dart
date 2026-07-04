class FamilyMemberBillingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FamilyMemberBillingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FamilyMemberBillingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FamilyMemberBillingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
