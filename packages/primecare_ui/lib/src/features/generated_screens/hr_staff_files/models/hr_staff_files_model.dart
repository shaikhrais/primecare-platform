class HrStaffFilesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrStaffFilesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrStaffFilesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrStaffFilesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
