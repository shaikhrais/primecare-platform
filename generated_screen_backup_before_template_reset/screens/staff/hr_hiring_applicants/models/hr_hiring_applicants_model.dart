class HrHiringApplicantsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrHiringApplicantsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrHiringApplicantsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrHiringApplicantsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
