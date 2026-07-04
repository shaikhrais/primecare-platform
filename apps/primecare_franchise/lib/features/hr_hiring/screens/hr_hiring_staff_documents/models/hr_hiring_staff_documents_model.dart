class HrHiringStaffDocumentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrHiringStaffDocumentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrHiringStaffDocumentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrHiringStaffDocumentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
