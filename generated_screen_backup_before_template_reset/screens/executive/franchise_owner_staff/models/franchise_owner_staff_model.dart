class FranchiseOwnerStaffModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FranchiseOwnerStaffModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FranchiseOwnerStaffModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FranchiseOwnerStaffModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
