class AttendanceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AttendanceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AttendanceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AttendanceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
