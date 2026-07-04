class HrDirectorStaffFilesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrDirectorStaffFilesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrDirectorStaffFilesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrDirectorStaffFilesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
