// Layer: 02_MODELS_FOUNDATION
class ReviewPeerPerformanceFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;

  ReviewPeerPerformanceFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
  });

  ReviewPeerPerformanceFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return ReviewPeerPerformanceFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
