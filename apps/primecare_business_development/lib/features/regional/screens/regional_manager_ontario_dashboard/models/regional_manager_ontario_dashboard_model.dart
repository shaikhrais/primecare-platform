class RegionalManagerOntarioDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RegionalManagerOntarioDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RegionalManagerOntarioDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RegionalManagerOntarioDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
