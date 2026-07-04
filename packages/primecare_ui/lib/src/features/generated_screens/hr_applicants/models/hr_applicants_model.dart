class HrApplicantsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrApplicantsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrApplicantsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrApplicantsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
