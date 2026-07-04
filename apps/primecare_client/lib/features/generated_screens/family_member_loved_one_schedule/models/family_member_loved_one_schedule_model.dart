class FamilyMemberLovedOneScheduleModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FamilyMemberLovedOneScheduleModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FamilyMemberLovedOneScheduleModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FamilyMemberLovedOneScheduleModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
