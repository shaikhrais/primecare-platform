class ShareholderDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ShareholderDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ShareholderDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ShareholderDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
