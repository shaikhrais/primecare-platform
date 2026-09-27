class SchoolHealthProgramDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SchoolHealthProgramDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SchoolHealthProgramDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SchoolHealthProgramDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
