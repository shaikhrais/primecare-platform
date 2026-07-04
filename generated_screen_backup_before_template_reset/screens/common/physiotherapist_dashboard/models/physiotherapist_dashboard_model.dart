class PhysiotherapistDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PhysiotherapistDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PhysiotherapistDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PhysiotherapistDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
